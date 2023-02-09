//
//  TimerListViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit

final class TimerListViewController: GradientViewController {

    var presenter: TimerListViewPresenterProtocol!
    var testingData = TestingData().data
    
    //MARK: - UI Components
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "There are no timers here yet"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        textLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        textLabel.text = "Add timers for your recipes here \nby pressing the timer button \non the recipe"
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private let characterLabel: UILabel = {
        let characterLabel = UILabel()
        characterLabel.text = "⏱️"
        characterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimerListCell.self, forCellReuseIdentifier: TimerListCell.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if testingData.isEmpty {
            setupEmptyView()
        } else {
            setupTableView()
        }
    }
}

//MARK: - TableViewDelegate & TableViewDataSource
extension TimerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { testingData.count }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnTimer()
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

        if testingData.count == 1 {
            text = "You have \(testingData.count) timer"
        } else if testingData.count > 1 {
            text = "You have \(testingData.count) timers"
        }
        let headerView: UIView = setTableViewHeader(width: tableView.frame.width,
                                                            height: 52,
                                                            text: text)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 76 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 52 }
}

//MARK: - ViewProtocol
extension TimerListViewController: TimerListViewProtocol {
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - Set up UI
extension TimerListViewController {
    
    func setupTableView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: 16)
        ])
    }
    
    func setupEmptyView() {
        
        view.addSubview(headerLabel)
        view.addSubview(characterLabel)
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 52),
            
            view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: 50),
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
}
