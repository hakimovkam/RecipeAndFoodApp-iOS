//
//  FavoritesViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit

final class FavoritesViewController: GradientViewController {
    
    var presenter: FavoriteViewPresenterProtocol!
    var testingData = TestingData().data

    //MARK: - UI Components
    private var lastContentOffset: CGFloat = 0
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        textLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        textLabel.text = "Save your favorite recipes here\nby pressing the star button"
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private lazy var characterLabel: UILabel = {
        let characterLabel = UILabel()
        characterLabel.text = "⭐"
        characterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterLabel
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Favorites"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search recipes"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(name: "Poppins-Regular", size: 16)
        searchBar.setImage(UIImage(named: "Union"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextPositionAdjustment.horizontal = 10
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .clear
        searchBar.layer.cornerRadius = 16
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        return searchBar
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        if testingData.isEmpty {
            setupEmptyView()
        } else {
            setupTableView()
        }
    }
}

//MARK: - TableViewDelegate and TableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return testingData.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.foodImage.image = UIImage(named: ImageConstant.cookImage)
        cell.recipeDescriptionLabel.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnRecipe()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 184 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = setTableViewHeader(width: tableView.frame.width,
                                            height: 52, text: "Favorite")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            if lastContentOffset < 50 {
                searchBar.alpha = 1 - (lastContentOffset * 0.04)
            }
        } else if self.lastContentOffset < scrollView.contentOffset.y {
            if lastContentOffset < 50 {
                searchBar.alpha = 1 - (lastContentOffset * 0.04)
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
//MARK: - SearchResultsUpdate
extension FavoritesViewController: UISearchBarDelegate {
}
//MARK: - View protocol
extension FavoritesViewController: FavoriteViewProtocol {
    func didUpdate() {
        print("didUpdate")
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - ViewLayout
extension FavoritesViewController {
    
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        navigationController?.navigationBar.showsLargeContentViewer = false
        tableView.tableHeaderView = searchBar
 
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: searchBar.rightAnchor , constant: 16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupEmptyView() {
        view.addSubview(searchBar)
        view.addSubview(characterLabel)
        view.addSubview(textLabel)
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: searchBar.rightAnchor , constant: 16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            
            view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: 50),
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
}
