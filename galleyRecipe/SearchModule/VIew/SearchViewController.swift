import UIKit

final class SearchViewController: GradientViewController, UISearchBarDelegate {

    var testingData = TestingData().data
    var countryData = TestingData().countryCategoryArray
    var categoryData = TestingData().nameCategoryArray

    //MARK: - UI Components
    let categoryCollectionView = ChipsCollectionView()
    let countryCollectionView = ChipsCollectionView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "UIKit Soup"
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //header label for empty screen
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "No recipes found"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLabel: UILabel = {
        let characterLabel = UILabel()
        characterLabel.text = "🤷️"
        characterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        textLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        textLabel.text = "Try changing some\nsearch parameters"
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageConstant.sortButton)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapToSortButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        if testingData.isEmpty {
            setupEmptyView()
        } else {
            setupTableView()
        }
    }
    
    @objc
    func tapToSortButton() {
        UIView.animate(withDuration: 0.1,
            animations: {
                self.sortButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.sortButton.transform = CGAffineTransform.identity
                }
            })
    }
}
//MARK: - TableViewDelegate & TableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return testingData.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.foodImage.image = UIImage(named: ImageConstant.cookImage)
        cell.recipeDescriptionLabel.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.tapOnTheRecipe()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 184 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var text = "No recipes found"

        if testingData.count == 1 {
            text = "Found \(testingData.count) recipe"
        } else if testingData.count > 1 {
            text = "Found \(testingData.count) recipes"
        }
        
        let headerView = setTableViewHeader(width: tableView.frame.width,
                                            height: 52,
                                            text: text)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
//MARK: - scrollView Methods
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.alpha = 0
        sortButton.alpha = 0
        categoryCollectionView.alpha = 0
        countryCollectionView.alpha = 0
        
        if scrollView.contentOffset.y < 100 {
            searchBar.alpha = 1 - (scrollView.contentOffset.y * 0.01)
            sortButton.alpha = 1 - (scrollView.contentOffset.y * 0.01)
            categoryCollectionView.alpha = 1 - (scrollView.contentOffset.y * 0.02)
            countryCollectionView.alpha = 1 - (scrollView.contentOffset.y * 0.05)
        }
    }
}
//MARK: - ChipsCollectionViewDelegate&DataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.countryCollectionView {
            return countryData.count
        } else {
            return categoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.countryCollectionView {
            let countryCell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identifier, for: indexPath) as! ChipsCollectionViewCell
            countryCell.label.text = countryData[indexPath.item]
            return countryCell
        } else {
            let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identifier, for: indexPath) as! ChipsCollectionViewCell
            categoryCell.label.text = categoryData[indexPath.item]
            return categoryCell
        }
    }
}
//MARK: - ChipsCollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayaut: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = UIFont(name: "Poppins-Regular", size: 14)
        let categoryAttributes = [NSAttributedString.Key.font : categoryFont as Any]
        if collectionView == self.countryCollectionView {
            let countryWidth = countryData[indexPath.item].size(withAttributes: categoryAttributes).width + 32
            return CGSize(width: countryWidth, height: collectionView.frame.height)
        } else {
            let categoryWidth = categoryData[indexPath.item].size(withAttributes: categoryAttributes).width + 32
            return CGSize(width: categoryWidth, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 4 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 4 }
}
//MARK: - set up UI
extension SearchViewController {
    func setupTableView() {
        
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 138))
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableHeaderView.addSubview(searchBar)
        tableHeaderView.addSubview(categoryCollectionView)
        tableHeaderView.addSubview(countryCollectionView)
        tableHeaderView.addSubview(sortButton)
        view.addSubview(tableHeaderView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        countryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.showsLargeContentViewer = false
        tableView.tableHeaderView = tableHeaderView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            tableHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableHeaderView.heightAnchor.constraint(equalToConstant: 138),
            
            searchBar.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor, constant: 16),
            sortButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10),
            searchBar.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 8),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            sortButton.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 21),
            tableHeaderView.rightAnchor.constraint(equalTo: sortButton.rightAnchor, constant: 16),
            sortButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10),
            sortButton.heightAnchor.constraint(equalToConstant: 24),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 32),

            countryCollectionView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor),
            countryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
            countryCollectionView.heightAnchor.constraint(equalToConstant: 32)
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
