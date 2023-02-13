//
//  TimerViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//
import AVFoundation
import AudioToolbox
import UIKit

final class TimerViewController: GradientViewController {

    private let presenter: TimerViewPresenterProtocol
    
    private var audioPlayer: AVAudioPlayer?
    private var timer = Timer()
    
    let totalTime = 5.0
    private let step = 0.01
    private var timeRemains = 5.0
    private var currentStep = 0
    private var isTimerStarted = false
    
    private var totalSteps: Int {
        Int(totalTime / step)
    }
    
    private let timerProgressView = TimerProgressView(
        frame: CGRect(x: 0.0, y: 0.0, width: 160, height: 160)
    )
    
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26   , weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        return label
    }()
  
    private lazy var playImage: UIImage = {
        createButtonImage(name: "play.fill")
    }()
    
    
    private lazy var pauseImage: UIImage = {
        createButtonImage(name: "pause.fill")
    }()
    
    private lazy var timerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(playImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(TimerViewController.self, action: #selector(resetTimer), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = timeString(time: TimeInterval(timeRemains))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
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
        setupSubviews(resetButton, counterLabel, timerProgressView, timerButton, dishNameLabel)
        setConstraints()
        timerProgressView.center = self.view.center
    }
}

// MARK: - Create Timer
extension TimerViewController {
    private func playSound() {
        guard let url = Bundle.main.url(
            forResource: "alarmSound",
            withExtension: "mp3"
        ) else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: step, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        timerButton.setImage(pauseImage, for: .normal)
    }

    @objc private func updateTimer() {
        if timeRemains < 1e-5 {
            timerProgressView.removeProgressStroke()
            timer.invalidate()
            playSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            timeRemains -= step
            timerProgressView.startAnimation(currentStep: currentStep, totalSteps: totalSteps)
            timerProgressView.changeStrokeColor(currentStep: currentStep, totalSteps: totalSteps)
            currentStep += 1
            counterLabel.text = timeString(time: TimeInterval(timeRemains))
        }
    }

    @objc private func toggleTimer() {
        if !isTimerStarted {
            timerButton.setImage(pauseImage, for: .normal)
            startTimer()
            toggleAnimation()
            isTimerStarted = true
        } else {
            timerProgressView.pauseAnimation()
            timerButton.setImage(playImage, for: .normal)
            isTimerStarted = false
            timer.invalidate()
        }
    }

    @objc private func resetTimer() {
        timer.invalidate()
        timerProgressView.resetAnimation()
        isTimerStarted = false
        timeRemains = totalTime
        currentStep = 0
        counterLabel.text = timeString(time: TimeInterval(timeRemains))
        timerButton.setImage(playImage, for: .normal)
    }

    private func timeString(time: CFTimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func toggleAnimation() {
        if !isTimerStarted {
            timerProgressView.resumeAnimation()
        } else {
            timerProgressView.resumeAnimation()
        }
    }
}

extension TimerViewController: TimerViewProtocol {
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - Setup the View
extension TimerViewController {
    
    private func createButtonImage(name: String) -> UIImage {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .regular, scale: .large)
        let image = UIImage(systemName: name, withConfiguration: imageConfig) ?? UIImage()
        return image
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dishNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: timerButton.topAnchor, constant: -60)
        ])

        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: timerProgressView.bottomAnchor, constant: 40),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
