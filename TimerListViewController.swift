//
//  TimerListViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit

class TimerListViewController: GradientViewController {

//    private var data = ["Pasta", "q", "Pasta", "3", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta"] // testing data
    
    private var data = [String]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimerListCell.self, forCellReuseIdentifier: TimerListCell.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 2.0 }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if data.isEmpty {
//            setupTableView()
            setupEmptyView()
        } else {
            setupTableView()
        }
    }

}

extension TimerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerListCell.identifier, for: indexPath) as! TimerListCell
        
        cell.foodImage.image = UIImage(named: ImageConstant.cookImage)
        cell.descriptionLabel.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        cell.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 0.775, green: 0.775, blue: 0.775, alpha: 1), thickness: 0.5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var text = "There are no timers here yet"
            
        if data.count == 1 {
            text = "You have \(data.count) timer"
            
        } else if data.count > 1 {
            text = "You have \(data.count) timers" }
        
        let headerView: UIView = setTableViewHeader(width: tableView.frame.width,
                                                    height: 52,
                                                    text: text)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 76 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 52 }
}

extension TimerListViewController {
    
    func setupTableView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
    
    }
    
    func setupEmptyView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        view.addSubview(emptyStackView)
        
        
        let charecterLabel = UILabel()
        charecterLabel.text = "⏱️"
        charecterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        charecterLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let textLabel = UILabel()
        textLabel.textColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        textLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        textLabel.text = "Add timers for your recipes here by pressing the timer button on the recipe"
        textLabel.numberOfLines = 5
        textLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 60)
        
        
        emptyStackView.axis = .vertical
        emptyStackView.distribution = .fillEqually
        emptyStackView.spacing = 20
        emptyStackView.addArrangedSubview(charecterLabel)
        emptyStackView.addArrangedSubview(textLabel)
        
        NSLayoutConstraint.activate([
            emptyStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
