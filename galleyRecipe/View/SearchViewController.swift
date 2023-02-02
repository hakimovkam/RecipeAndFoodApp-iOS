import UIKit

final class SearchViewController: GradientViewController, UISearchBarDelegate {

    private var data = ["Pasta", "q", "Pasta", "3", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta"] // testing data
    
//    private var data: [String] = []
//    var presenter: SearchViewPresenterProtocol!

    private var collectionView: UICollectionView?

    private var lastContentOffset: CGFloat = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: ChipsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(collectionView)
//        collectionView.frame =
        
//        if data.isEmpty {
//            setupEmptyView()
//        } else {
//            setupTableView()
//        }
    }
}



extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.foodImage.image = UIImage(named: ImageConstant.cookImage)
        cell.recipeDescriptionLabel.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 184 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var text = "No recipes found"

        if data.count == 1 {
            text = "Found \(data.count) recipe"
        } else if data.count > 1 {
            text = "Found \(data.count) recipes"
        }
        
        let headerView = setTableViewHeader(width: tableView.frame.width,
                                            height: 52,
                                            text: text)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Анимация исчезновения search bar при скролле
        if (self.lastContentOffset > scrollView.contentOffset.y) { // move up
            if lastContentOffset < 50 {
                searchBar.alpha = 1 - (lastContentOffset * 0.04)
            }
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) { // move down
            if lastContentOffset < 50 {
                searchBar.alpha = 1 - (lastContentOffset * 0.04)
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y // update the new position acquired
    }
}

extension SearchViewController: UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identifier, for: indexPath) as! ChipsCollectionViewCell
        
        return cell
    }
    
    
}

extension SearchViewController {
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
