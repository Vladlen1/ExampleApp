//
//  SearchViewController.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import UIKit

final class SearchViewController: UIViewController {
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var activityIndicator: UIActivityIndicatorView!

    private let searchCellId = "SearchCell"
    private let viewModel: SearchViewModelProtocol
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupSearchBar()
        setupActivityIndicator()
        
        fetchAlbums()
    }
    
    private func setupView() {
        tableView = UITableView()
        searchBar = UISearchBar()
        activityIndicator = UIActivityIndicatorView(style: .medium)

        [tableView, searchBar, activityIndicator].forEach { view.addSubview($0) }
        view.backgroundColor = .white
    }
    
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchCellId)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = StringConstants.searchArtistPlaceHolder
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
                
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchAlbums(for artistName: String? = nil) {
        showLoader()
        viewModel.fetchAlbums(for: artistName) { [weak self] error in
            self?.hideLoader()
            self?.tableView.reloadData()

            if let error = error {
                self?.showErrorAlert(with: error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewModelCells.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: searchCellId, for: indexPath) as? SearchTableViewCell {
            cell.setup(with: viewModel.viewModelCells[indexPath.row])

            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            fetchAlbums(for: searchText)
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            fetchAlbums()
        }
    }
}

// MARK: - Helper

extension SearchViewController {
    
    private func hideLoader() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    private func showLoader() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
}
