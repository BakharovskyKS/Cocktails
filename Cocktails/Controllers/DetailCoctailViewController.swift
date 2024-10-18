//
//  DetailCoctailViewController.swift
//  Cocktails
//
//  Created by Кирилл Бахаровский on 10/19/24.
//

import UIKit

class DetailCoctailViewController: UIViewController {
    
    var cocktail: Cocktail = Cocktail(name: nil , instructions: "1", ingredients: [])
    
    private let idTableViewCell = "DetailCocktailTableViewCell"
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Инструкция"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        title = cocktail.name
        instructionsLabel.text = cocktail.instructions
        setupViews()
        setConstraints()
        setDelegate()
        tableView.register(DetailCocktailTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension DetailCoctailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = cocktail.ingredients else { return 1}
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? DetailCocktailTableViewCell else {
            return UITableViewCell() }
        guard let ingredient = cocktail.ingredients?[indexPath.row] else { return cell }
        cell.configure(ingredient: "\(ingredient)")
        
        return cell
    }
}

extension DetailCoctailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


extension DetailCoctailViewController {
    private func setupViews() {
        view.addSubview(instructionsLabel)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

