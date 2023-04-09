//
//  TimerListViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit
import RealmSwift

final class TimerListViewController: GradientViewController {
    enum Localization {
        static let textLabelStub: String = "Add timers for your recipes here \nby pressing the timer button \non the recipe"
        static let textLabelChar: String = "⏱️"
        static let headerLabelOnEmptyScreen: String = "There are no timers here yet"
        static let placeholder: String = "UIKit Soup"
    }

    private let presenter: TimerListViewPresenterProtocol
    private lazy var results: Results<RealmRecipe> = presenter.getTimerRecipes()
    private lazy var lastNumberOfRecipe = results.count
    private var cellWillDisplayAction = false

    // MARK: - UI Components
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = Localization.headerLabelOnEmptyScreen
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textLabel: UILabel = {
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

    private let characterLabel: UILabel = {
        let characterLabel = UILabel()
        characterLabel.text = Localization.textLabelChar
        characterLabel.font = UIFont(name: "Poppins-Bold", size: 100)
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        return characterLabel
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimerListCell.self, forCellReuseIdentifier: TimerListCell.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(presenter: TimerListViewPresenterProtocol) {
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

        setLayot()

        characterLabel.alpha = 0
        textLabel.alpha = 0

        cellWillDisplayAction = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRecipesCount(tableViewUpdateAction: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cellWillDisplayAction = false
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
// MARK: - TableViewDelegate & TableViewDataSource
extension TimerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return results.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerListCell.identifier, for: indexPath) as? TimerListCell else { return UITableViewCell() }

        let model = results[indexPath.row]
        cell.selectionStyle = .none

        cell.configure(imageUrlString: model.image, timer: model.readyInMinutes, descriptionLabelText: model.title)
        cell.layer.addBorder(edge: UIRectEdge.bottom, color: .textColor, thickness: 0.5, offset: 16)
        return cell
    }
}

extension TimerListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.saveOrDeleteFavoriteRecipe(id: results[indexPath.row].id, action: .fromTimer)
            checkRecipesCount(tableViewUpdateAction: true)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        var text = "There are no timers here yet"

        if results.count == 1 {
            text = "You have \(results.count) timer"
        } else if results.count > 1 {
            text = "You have \(results.count) timers"
        }
        let headerView: UIView = setTableViewHeader(width: tableView.frame.width,
                                                    height: .tableViewHeader,
                                                            text: text)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return .timerTableViewCellHeigh }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return .tableViewHeader }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapOnTimer()
    }
}
// MARK: - ViewProtocol
extension TimerListViewController: TimerListViewProtocol {
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - Set up UI
extension TimerListViewController {

    func setLayot() {
        view.addSubview(tableView)
        view.addSubview(characterLabel)
        view.addSubview(textLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor/*, constant: .mediemLeftRightInset*/),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor /*,constant: .mediemLeftRightInset*/),

            view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: .characterXAnchor),
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
}
