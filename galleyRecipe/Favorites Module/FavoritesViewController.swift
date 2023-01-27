//
//  FavoritesViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit

class FavoritesViewController: GradientViewController {
    
    var presenter: FavoriteViewPresenterProtocol!
    
    private var data = ["Pasta", "q", "Pasta", "3", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta"] // testing data
    
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
//        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.placeholder = "Search recipes"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(name: "Poppins-Regular", size: 16)
        searchBar.setImage(UIImage(named: "Union"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextPositionAdjustment.horizontal = 10
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 10
        
        searchBar.layer.cornerRadius = 16
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        
        
        print(searchBar.frame.width - 200)
        
//        let rounderLayer = CAShapeLayer()
//        let besierPath = UIBezierPath(roundedRect: CGRect(x: 0,
//                                                          y: 8,
//                                                          width: searchBar.frame.width - 32,
//                                                          height: 50),
//                                      cornerRadius: 10)
//        rounderLayer.path = besierPath.cgPath
//        searchBar.layer.insertSublayer(rounderLayer, at: 0)
//        rounderLayer.fillColor = UIColor.white.cgColor
//        searchBar.layer.shadowColor = UIColor.darkGray.cgColor
//        searchBar.layer.shadowOpacity = 1
//        searchBar.layer.shadowOffset = CGSize.zero
//        searchBar.layer.shadowRadius = 1
        
       
        
        
        return searchBar
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        print(view.frame.width)
        
        setupViews()
        setConstraint()
    }
    
    @objc func favoriteButtonPressed(sender: UIButton) {
        let rowIndex:Int = sender.tag
        print(rowIndex)
        print("favoriteButtonPressed")
    }
    
    @objc func timerButtonPressed(sender: UIButton) {
        let rowIndex:Int = sender.tag
        print(rowIndex)
        print("timerButtonPressed")
    }
}

//MARK: - TableViewDelegate and TableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 25 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.foodImage.image = UIImage(named: ImageConstant.cookImage)
        cell.recipeDescriptionLabel.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed(sender: )), for: .touchUpInside)
        
        cell.timerButton.tag = indexPath.row
        cell.timerButton.addTarget(self, action: #selector(timerButtonPressed(sender: )), for: .touchUpInside)
        
        return cell
    }

    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = IngredientsViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 184 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 52))
        
        /* set custom blur effect in tableViewHeader */
        //MARK: - label
        let label = UILabel()
        label.backgroundColor = .clear
        label.frame = CGRect.init(x: 16, y: 14, width: tableView.frame.width, height: 24)
        label.text = "Favorites"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.textColor = .black
        
        //MARK: - blurEffect
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = LightBlurEffectView(effect: blurEffect, intensity: 0.2)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = headerView.frame
        
        let additionalView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 52)
            view.backgroundColor = .white
            view.alpha = 0.7
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()
        
        //MARK: - gradient
        let gradientView: UIView = {
            let view = UIView()
            view.frame = headerView.frame
            view.backgroundColor = .white
            let gradient = CAGradientLayer()
            gradient.frame = headerView.frame
            gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0, 1]
            view.layer.mask = gradient
            return view
        }()
        
        //MARK: - added view components to the table view header
        
        headerView.addSubview(blurView)
        headerView.addSubview(additionalView)
        headerView.addSubview(gradientView)
        headerView.addSubview(label)
        
        return headerView
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
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
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        tableView.tableHeaderView = searchBar
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
