import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let searchController = UISearchController(searchResultsController: nil)//  1- создаем серчбар

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
    
    private var galleryCollectionView = GalleryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        navigationItem.searchController = searchController
        setupEmptyView()
        configCollectionView()
        searchBar.delegate = self
        galleryCollectionView.set(cells: ChipsBar.chipsButton())
        
    }

    func setupEmptyView() {
        
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).self, //правый край
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 50).self, //пропадает без
           // searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50).self,
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 67).self, // верх
            searchBar.heightAnchor.constraint(equalToConstant: 50).self // ширина обшая
        ])
    }
    
    func configCollectionView() {
        view.addSubview(galleryCollectionView)
        view.backgroundColor = .white
        
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: searchBar.centerYAnchor, constant: 26).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 42).isActive = true // размер ячейки по высоте
    }

}

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cells = [ChipsBar]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .white // цвет фона коллекции
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        //layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        layout.minimumLineSpacing = 18 // между
        contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12) //от стенок
        //contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)

        //убираем скролл индикатор
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func set(cells: [ChipsBar]) {
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
        //cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        
        cell.nameLabel.text = cells[indexPath.row].barsName
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       // CGSize(width: Constants.galleryItemWidth, height: frame.height * 0.8)
        return CGSize(width: 74, height: 32)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct ChipsBar {
    var barsName: String
    
    static func chipsButton() -> [ChipsBar] {
        let firstItem = ChipsBar(barsName: "soups")
        
        let secondItem = ChipsBar(barsName: "salads")
        
        let thirdItem = ChipsBar(barsName: "meat")
        
        let fouthItem = ChipsBar(barsName: "deserts")
        
        let five = ChipsBar(barsName: "bakery")
        
        let six = ChipsBar(barsName: "1")
        
        let seven = ChipsBar(barsName: "2")
        
        let eight = ChipsBar(barsName: "3")
        
        
        return [firstItem, secondItem, thirdItem, fouthItem, five, six, seven, eight]
    }
}

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    // настройка шрифта
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) // размер шрифта , шрифт
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //текста на кнопке
    let smallDescriptionLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        //label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        
        backgroundColor = .white // цвет фона конопки
        
        // nameLabel constraints
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6).isActive = true
       // nameLabel.heightAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
       // nameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 42).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 16
        self.layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//import UIKit
////class CustomTableViewCell: UITableViewCell переиспользовать
////static let identifier = "CustomTableViewCell"
//class SearchViewController: UIViewController {
//
//    private let searchController = UISearchController(searchResultsController: nil)//  1- создаем серчбар
//
//    let searchView = UISearchBar()
//    let tableView = UITableView() // таблица
//    let searchBar = UISearchBar()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 1.2 поиск по всей длинне
//        navigationItem.searchController = searchController
//
//        configTableView()
//    }
//    //3.2 - поиск справа верх угол
//    @objc func handleShowSearchBar() {
//        search(shouldShou: true)// 3.3 - отмена поиска
//        searchBar.becomeFirstResponder() //строка сразу активна для набота текста
//    }
//
//    func configTableView() {
//
//        view.backgroundColor = .green
//
//        searchBar.sizeToFit()
//        searchBar.delegate = self
//
//        view.addSubview(searchView) // вью центрального поиска
//        //navigationController?.navigationBar.prefersLargeTitles = true // крупный текст шапки
//        navigationItem.title = "Search" // текст в шапке
//        navigationController?.navigationBar.isTranslucent = false // не прозрачная
//        navigationController?.navigationBar.barStyle = .black // строка состояния белая
//        navigationController?.navigationBar.tintColor = .white // цвет лупы белый
//        showSearchBarButton(shouldShow: true)
//        view.addSubview(tableView) // вью таблицы
//        tableView.pin(to: view) // 2.1 появление и расположение таблицы
//        setTableViewDelegates()
//    }
//    //2.3 отображение таблицы
//    func setTableViewDelegates() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    func showSearchBarButton(shouldShow: Bool) {
//        if shouldShow {
//            // 3.1 кнопка бара справа в верху параметры
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
//                                                                target: self,
//                                                                action: #selector(handleShowSearchBar))
//        } else {
//            navigationItem.rightBarButtonItem = nil // анимация пропадает лупа
//        }
//    }
//    // 3.3 поиск
//    func search(shouldShou: Bool) {
//        showSearchBarButton(shouldShow: !shouldShou)
//        searchBar.showsCancelButton = shouldShou
//        navigationItem.titleView = shouldShou ? searchBar : nil
//    }
//
//}
//
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    // количество строк в таблице
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
//
//// 2.2 расположение таблицы
//extension UIView {
//    func pin(to superView: UIView) {
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            topAnchor.constraint(equalTo: superView.topAnchor, constant: 50), // от серчбара верха
//            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
//            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
//            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
//        ])
//    }
//
//}
//
//extension SearchViewController: UISearchBarDelegate {
//    // отмена кнопки отмена
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        search(shouldShou: false)
//    }
//}
