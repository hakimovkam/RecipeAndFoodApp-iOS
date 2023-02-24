//
//  FavoritesViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit
import Kingfisher

final class FavoritesViewController: GradientViewController {
    enum Localization {
        static let textLabelStub: String = "Save your favorite recipes here\nby pressing the star button"
        static let textLabelChar: String = "⭐"
        static let headerLabel: String = "Favorites"
        static let placeholder: String = "Search recipes"
    }
    private var topConstraint: NSLayoutConstraint!
    private let presenter: FavoriteViewPresenterProtocol

    //MARK: - UI ComponentsadvancedTableViewHeader
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .textColor
        textLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        textLabel.text = Localization.textLabelStub
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private lazy var characterLabel: UILabel = {
        let characterLabel = UILabel()
        characterLabel.text = Localization.textLabelChar
        characterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterLabel
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = Localization.headerLabel
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = Localization.placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(name: "Poppins-Regular", size: 16)
        searchBar.setImage(UIImage(named: "Union"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextPositionAdjustment.horizontal = 10
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .clear
        searchBar.layer.cornerRadius = 16
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.customBorderColor.cgColor
        return searchBar
    }()
    
    init(presenter: FavoriteViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        setLayout()

    }
}
//MARK: - TableViewDelegate and TableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return presenter.recipes?.count ?? 0}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        guard let model = presenter.recipes?[indexPath.row] else { return UITableViewCell() }
        cell.configure(recipeDescription: model.title, recipeImageUrl: model.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.2,
            delay: 0.01 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnRecipe()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return .recipeTableViewCellHeigh }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = setTableViewHeader(width: tableView.frame.width,
                                            height: .tableViewHeader, text: Localization.headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return .tableViewHeader }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.alpha = 0
        
        if scrollView.contentOffset.y - .tableViewHeader < .searchBarHeight {
            let offset = max(0, scrollView.contentOffset.y - .tableViewHeader)
            searchBar.alpha = 1 - (offset / .searchBarHeight * 1)
            topConstraint.constant = -offset + .smallTopAndBottomInset
        }
    }
}
//MARK: - SearchResultsUpdate
extension FavoritesViewController: UISearchBarDelegate {
}
//MARK: - View protocol
extension FavoritesViewController: FavoriteViewProtocol {
   
    func success() {
        tableView.reloadData()
        tableView.allowsSelection = true
        tableView.alwaysBounceVertical = true
        
        UIView.animate(withDuration: 0.4) {
            self.characterLabel.alpha = 0
            self.textLabel.alpha = 0
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - ViewLayout
extension FavoritesViewController {
    
    func setLayout() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        view.addSubview(characterLabel)
        view.addSubview(textLabel)
        topConstraint = searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .smallTopAndBottomInset)
        
        navigationController?.navigationBar.showsLargeContentViewer = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: .smallTopAndBottomInset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: searchBar.rightAnchor , constant: .mediemLeftRightInset),
            topConstraint,
            searchBar.heightAnchor.constraint(equalToConstant: .searchBarHeight),
            
            view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: .characterXAnchor - .tableViewHeader),
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
    
}
