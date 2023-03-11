//
//  FavoritesViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit
import RealmSwift

final class FavoritesViewController: GradientViewController {
    enum Localization {
        static let textLabelStub: String = "Save your favorite recipes here\nby pressing the star button"
        static let textLabelChar: String = "⭐"
        static let headerLabel: String = "Favorites"
        static let placeholder: String = "Search recipes"
    }

    private let presenter: FavoriteViewPresenterProtocol
    private lazy var results: Results<RealmFavoriteRecipe> = presenter.getFavoriteObjs()
    private var keyboardHeightConstraint: NSLayoutConstraint!
    private var cellWillDisplayAction: Bool = false
    private lazy var lastNumberOfRecipe = results.count

    // MARK: - UI ComponentsadvancedTableViewHeader

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

        setLayout()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        cellWillDisplayAction = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRecipesCount(tableViewUpdateAction: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cellWillDisplayAction = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if lastNumberOfRecipe == 0 {
            cellWillDisplayAction = true
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
        lastNumberOfRecipe = results.count
    }

    // MARK: - keyboardManager
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            animateWithKeyboard(notification: notification) { (_) in
                self.keyboardHeightConstraint.constant = .characterXAnchor - .tableViewHeader + (keyboardSize.height / 2) - self.textLabel.frame.height
            }
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        animateWithKeyboard(notification: notification) { (_) in
            self.keyboardHeightConstraint.constant = .characterXAnchor - .tableViewHeader
        }
    }
    // MARK: - results manager
    func checkRecipesCount(tableViewUpdateAction: Bool) {
        if !results.isEmpty {
            tableView.isScrollEnabled = true
            UIView.animate(withDuration: 0.1) {
                self.characterLabel.alpha = 0
                self.textLabel.alpha = 0
            }
        } else {
            tableView.isScrollEnabled = false
            UIView.animate(withDuration: 0.1) {
                self.characterLabel.alpha = 1
                self.textLabel.alpha = 1
            }
        }

        if tableViewUpdateAction {
            tableView.beginUpdates()
            tableView.reloadSections(.init(integer: 0), with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }
}

// MARK: - TableViewDelegate and TableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return results.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }

        let model = results[indexPath.row]
        cell.selectionStyle = .none

        let favoriteButton = { [weak self] in
            guard let self = self else { return }
            self.presenter.saveOrDeleteFavoriteRecipe(id: model.id)
            self.checkRecipesCount(tableViewUpdateAction: true)
        }

        let timerButton = {
        }

        cell.configure(recipeDescription: model.title, imageUrlString: model.image, favoriteButton: favoriteButton, timerButotn: timerButton, isFavorite: true)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapOnRecipe()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return .recipeTableViewCellHeigh }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = setTableViewHeader(width: tableView.frame.width,
                                            height: .tableViewHeader, text: Localization.headerLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return .tableViewHeader }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cellWillDisplayAction {
            cell.alpha = 0

            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.alpha = 0

        if scrollView.contentOffset.y < 100 {
            searchBar.alpha = 1 - (scrollView.contentOffset.y * 0.05)
        }
    }
}
// MARK: - SeachBarDelegate
extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            results = presenter.getFavoriteObjs()
            checkRecipesCount(tableViewUpdateAction: false)
        } else {
            let result = presenter.getResultsByRequestFromSearchBar(request: searchText)
            results = result
            checkRecipesCount(tableViewUpdateAction: false)
        }
    }
}
// MARK: - View protocol
extension FavoritesViewController: FavoriteViewProtocol {

    func success() {}

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - ViewLayout
extension FavoritesViewController {

    func setLayout() {
        view.addSubview(tableView)
        view.addSubview(searchBar)

        view.addSubview(characterLabel)
        view.addSubview(textLabel)

        navigationController?.navigationBar.showsLargeContentViewer = false
        tableView.tableHeaderView = searchBar
        keyboardHeightConstraint = view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: .characterXAnchor - .tableViewHeader)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .smallTopAndBottomInset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: .mediemLeftRightInset),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .smallTopAndBottomInset),
            searchBar.heightAnchor.constraint(equalToConstant: .searchBarHeight),

            keyboardHeightConstraint, // characterLabel.centerYAcnchor 
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
}
