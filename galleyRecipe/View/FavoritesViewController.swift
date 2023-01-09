//
//  FavoritesViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var data = ["C++", "C", "C#", "Objective C", "Swift", "Python", "Kotlin", "Java", "JavaScrypt", "PHP", "1", "2", "3", "4", "5", "6", "7", "8", "9"] // testing data
    
    let button = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        setupViews()
        setConstraint()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        if #available(iOS 15.0, *) {
            button.configuration = .filled()
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 15.0, *) {
            button.configuration?.baseBackgroundColor = .systemBlue
        } else {
            button.backgroundColor = .systemBlue
        }
        if #available(iOS 15.0, *) {
            button.configuration?.title = "OK"
        } else {
            button.titleLabel?.text = "OK"
        }
        button.translatesAutoresizingMaskIntoConstraints = false
    }
}

class TableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
        
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesViewController {
    func setConstraint() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            
        ])
    }
}
