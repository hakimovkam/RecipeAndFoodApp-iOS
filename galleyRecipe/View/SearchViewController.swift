import UIKit

class SearchViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)//  1- создаем серчбар

    let searchView = UISearchBar()
    let tableView = UITableView() // таблица
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.2 поиск по всей длинне
        navigationItem.searchController = searchController
        
        configTableView()
    }
    //3.2 - поиск справа верх угол
    @objc func handleShowSearchBar() {
        search(shouldShou: true)// 3.3 - отмена поиска
        searchBar.becomeFirstResponder() //строка сразу активна для набота текста
    }
    
    func configTableView() {
        
        view.backgroundColor = .green
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        view.addSubview(searchView) // вью центрального поиска
        //navigationController?.navigationBar.prefersLargeTitles = true // крупный текст шапки
        navigationItem.title = "Search" // текст в шапке
        navigationController?.navigationBar.isTranslucent = false // не прозрачная
        navigationController?.navigationBar.barStyle = .black // строка состояния белая
        navigationController?.navigationBar.tintColor = .white // цвет лупы белый
        showSearchBarButton(shouldShow: true)
        view.addSubview(tableView) // вью таблицы
        tableView.pin(to: view) // 2.1 появление и расположение таблицы
        setTableViewDelegates()
    }
    //2.3 отображение таблицы
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            // 3.1 кнопка бара справа в верху параметры
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil // анимация пропадает лупа
        }
    }
    // 3.3 поиск
    func search(shouldShou: Bool) {
        showSearchBarButton(shouldShow: !shouldShou)
        searchBar.showsCancelButton = shouldShou
        navigationItem.titleView = shouldShou ? searchBar : nil
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// 2.2 расположение таблицы
extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: 50), // от серчбара верха
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    // отмена кнопки отмена
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShou: false)
    }
}
