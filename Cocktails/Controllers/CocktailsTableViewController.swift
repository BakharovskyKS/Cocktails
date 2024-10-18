//
//  MainTableViewController.swift
//  Cocktails
//
//  Created by Кирилл Бахаровский on 10/19/24.
//

import UIKit

class CocktailsTableViewController: UIViewController {
    
    let apiKey = "Vhcf8bKicFCR2N+c2kRDvQ==OPDEHb85Js8GiCgf"
    var nameOfCoctail = ""
    
    var cocktails = [Cocktail]()
    
    private let idTableViewCell = "CocktailsTableViewCell"
    
    private let searchController = UISearchController()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cocktails"
        
        setupViews()
        setConstraints()
        setDelegate()
        setupSearchController()
        tableView.register(CocktailsTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search coctail"
        searchController.obscuresBackgroundDuringPresentation = false // Чтобы таблица не затемнялась во время поиска
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
}

extension CocktailsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? CocktailsTableViewCell else {
            return UITableViewCell() }
        let cocktail = cocktails[indexPath.row]
        cell.configure(cocktail: cocktail)
        
        return cell
    }
}

extension CocktailsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let name = searchController.searchBar.text else { return }
        nameOfCoctail = name
        NetworkingManager.shared.fetchData(from: name, apiKey: apiKey) { localCocktails in
            guard let localCocktails = localCocktails else { return }
            self.cocktails = localCocktails
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Обновляем таблицу
        tableView.reloadData()
        print(nameOfCoctail)
    }
    
}

extension CocktailsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailCoctailViewController()
        vc.cocktail = cocktails[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


extension CocktailsTableViewController {
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
