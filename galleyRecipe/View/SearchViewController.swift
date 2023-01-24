import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let blurView: LightBlurEffectView = {
            let view = LightBlurEffectView()
            view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 52)
            view.clipsToBounds = true
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            
            view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        blurView.effect = UIBlurEffect(style: .light)
        
        let customView: UIView = {
            let view = UIView.init(frame: CGRect.init(x: view.frame.midX, y: view.frame.midY, width: 400, height: 400))
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let text: UILabel = UILabel()
        text.text = "adfsvfbdgfsdas"
        text.font = UIFont(name: "Poppins", size: 24)
        text.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: 400, height: 50)
        
        
        view.addSubview(blurView)
        view.addSubview(customView)
        view.addSubview(text)
        
    }
}

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
