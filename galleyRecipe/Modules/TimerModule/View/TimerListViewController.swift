//
//  TimerListViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit

final class TimerListViewController: GradientViewController {
    enum Localization {
        static let textLabelStub: String = "Add timers for your recipes here \nby pressing the timer button \non the recipe"
        static let textLabelChar: String = "⏱️"
        static let headerLabelOnEmptyScreen: String = "There are no timers here yet"
        static let placeholder: String = "UIKit Soup"
    }

    private let presenter: TimerListViewPresenterProtocol

    var testingData = TestingData().data
    let testingTimer = TestingData().timer
    let testingDescription = TestingData().recipeDescription

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

    private let tableView: UITableView = {
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

//        tableView.allowsSelection = false
//        tableView.alwaysBounceVertical = false

        setLayot()
        characterLabel.alpha = 0
        textLabel.alpha = 0

    }
}
// MARK: - TableViewDelegate & TableViewDataSource
extension TimerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { testingData.count }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnTimer()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerListCell.identifier, for: indexPath) as? TimerListCell else { return UITableViewCell() }

        cell.configure(foodImageName: ImageConstant.cookImage, timer: testingTimer, descriptionLabelText: testingDescription)
        cell.layer.addBorder(edge: UIRectEdge.bottom, color: .textColor, thickness: 0.5)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        var text = "There are no timers here yet"

        if testingData.count == 1 {
            text = "You have \(testingData.count) timer"
        } else if testingData.count > 1 {
            text = "You have \(testingData.count) timers"
        }
        let headerView: UIView = setTableViewHeader(width: tableView.frame.width,
                                                    height: .tableViewHeader,
                                                            text: text)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return .timerTableViewCellHeigh }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return .tableViewHeader }
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
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: .mediemLeftRightInset),

            view.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor, constant: .characterXAnchor),
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor)
        ])
    }
}
