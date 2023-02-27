//
//  TimerViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//
import AVFoundation
import UIKit

final class TimerViewController: GradientViewController {

    let testingData = TestingData()
    
    private let presenter: TimerViewPresenterProtocol

    private var audioPlayer: AVAudioPlayer?
    private var timer = Timer()

    private var totalTime: Double {
        Double("5") ?? 0
    }
    
    private let step = timerConstants.step
    private lazy var timeRemains = totalTime
    private var currentStep = timerConstants.currentStep

    private var isTimerStarted = false

    private var totalSteps: Int {
        Int(totalTime / step)
    }

    private let timerProgressView = TimerProgressView(
        frame: CGRect(x: .zero, y: .zero, width: .timerProgressViewWidth, height: .timerProgressViewWidth)
    )
    
    private let backbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageConstant.arrowLeft), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont(name: .poppinsRegular, size: .buttonFontSixe)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = testingData.recipeDescription
        return label
    }()

    private lazy var playImage: UIImage = {
        createButtonImage(name: ImageConstant.playButton)
    }()

    private lazy var pauseImage: UIImage = {
        createButtonImage(name: ImageConstant.pauseButonc)
    }()
    
    private func createButtonImage(name: String) -> UIImage {
        guard let image = UIImage(named: name) else { return UIImage() }
        let resizedImage = image.resize(targetSize: CGSize(width: .imageWidth, height: .imageHeigth))
        return resizedImage
    }
    
    private lazy var timerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(playImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    private lazy var resetButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle(.resetButton, for: .normal)

        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: .poppinsRegular, size: .buttonFontSixe)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = timeString(time: TimeInterval(timeRemains))
        label.textAlignment = .left
        label.font = UIFont(name: .poppinsBold, size: .labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(presenter: TimerViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        timerProgressView.center = self.view.center
        setupSubviews(resetButton, counterLabel, timerProgressView,
                      timerButton, dishNameLabel, backbutton)
        setConstraints()
    }
}
// MARK: - Create Timer
extension TimerViewController {
    private func playSound() {
        guard let url = Bundle.main.url(
            forResource: .alarmSound,
            withExtension: .alarmSoundExtension
        ) else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: step, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        timerButton.setImage(pauseImage, for: .normal)
    }

    @objc private func updateTimer() {
        if timeRemains < .tenPowFive {
            timerProgressView.removeProgressStroke()
            timer.invalidate()
            playSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            timeRemains -= step
            timerProgressView.startAnimation(currentStep: currentStep, totalSteps: totalSteps)
            timerProgressView.changeStrokeColor(currentStep: currentStep, totalSteps: totalSteps)
            currentStep += .one
            counterLabel.text = timeString(time: TimeInterval(timeRemains))
        }
    }

    @objc private func toggleTimer() {
        if !isTimerStarted {
            timerButton.setImage(pauseImage, for: .normal)
            startTimer()
            toggleAnimation()
            isTimerStarted = true
            counterLabel.textColor = UIColor.black
            counterLabel.font = UIFont(name: .poppinsBold, size: .labelFontSize)
        } else {
            timerProgressView.pauseAnimation()
            timerButton.setImage(playImage, for: .normal)
            isTimerStarted = false
            counterLabel.textColor = UIColor.customGray
            counterLabel.font = UIFont(name: .poppinsRegular, size: .labelFontSize)
            timer.invalidate()
        }
    }

    @objc private func resetTimer() {
        timer.invalidate()
        timerProgressView.resetAnimation()
        isTimerStarted = false
        timeRemains = totalTime
        currentStep = .zero
        counterLabel.textColor = UIColor.black
        counterLabel.text = timeString(time: TimeInterval(timeRemains))
        timerButton.setImage(playImage, for: .normal)
    }

    private func timeString(time: CFTimeInterval) -> String {
        let minutes = Int(time) / .sixty % .sixty
        let seconds = Int(time) % .sixty

        return String(format:.stringFormat, minutes, seconds)
    }

    private func toggleAnimation() {
        if !isTimerStarted {
            timerProgressView.resumeAnimation()
        } else {
            timerProgressView.resumeAnimation()
        }
    }
}

// MARK: - ViewProtocol
extension TimerViewController: TimerViewProtocol {
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - Setup the View
extension TimerViewController {
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backbutton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backbutton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .backButtonLeftAnchor)
        ])

        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: backbutton.bottomAnchor),
            dishNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .backButtonLeftAnchor),
            dishNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: .dishNameLabelRigthAnchor)
        ])
   
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: timerButton.topAnchor, constant: .counterLabelBottomAnchor)
        ])

        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: timerProgressView.bottomAnchor, constant: .resetButtonTopAnchor),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension String {
    static var poppinsRegular: String { "Poppins-Regular" }
    static var poppinsBold: String { "Poppins-Bold" }
    
    static var alarmSound: String { "alarmSound" }
    static var alarmSoundExtension: String { "mp3" }
    static var resetButton: String { "Reset" }
    
    static var stringFormat: String { "%02i:%02i" }
}

extension Int {
    static var sixty: Int { 60 }
    static var one: Int { 1 }
}

extension Double {
    static var tenPowFive: Double { 1e-5 }
    
    static var imageWidth: Double { 46.0 }
    static var imageHeigth: Double { 67.0 }
    
    static var step: Double { 0.01 }
    
    static var timerProgressViewWidth: Double { 160 }
}

extension CGFloat {
    static var labelFontSize: CGFloat { 64 }
    static var buttonFontSixe: CGFloat { 24 }
}

struct timerConstants {
    static var step = 0.01
    static var currentStep = 0
}
