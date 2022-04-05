//
//  SearchController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit

class SearchController: UITableViewController {
    // MARK: - Properties
    
    private var users = [User]()
    private var filteredUsers = [User]()

    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchModel: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        fetchUsers()
    }
    
    // MARK: - API

    func fetchUsers() {
        UserService.fetchUsers { users in
            print("DEBUG: Users in search controller: \(users)")
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers

    func configureTableView() {
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        // 设置结果更新回调! searchText 的回调服务
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - TableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchModel ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        
        let user = inSearchModel ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

// MARK: - TableViewDelegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchModel ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        print("DEBUG: SearchText: \(searchText)")
        filteredUsers = users.filter { $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)
        }
        print("DEBUG: \(filteredUsers)")
        tableView.reloadData()
    }
}
