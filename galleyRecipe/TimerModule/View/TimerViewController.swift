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

    var presenter: TimerViewPresenterProtocol
    
    private var audioPlayer: AVAudioPlayer?
    private var timer = Timer()
    private var secondsRemain = 5

    private var soundEnabled = true
    private var isTimerRunning = false
    private var resumeTapped = false

    private lazy var pauseButton: UIButton = {
        createButton(
            withTitle: "Pause",
            action: UIAction { [unowned self] _ in
            pauseTimer()
        })
    }()

    private lazy var startButton: UIButton = {
        createButton(
            withTitle: "Start",
            action: UIAction { [unowned self] _ in
            runTimer()
        })
    }()

    private lazy var resetButton: UIButton = {
        createButton(
            withTitle: "Reset",
            action: UIAction { [unowned self] _ in
            resetTimer()
        })
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = timeString(time: TimeInterval(secondsRemain))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 80, weight: .light)
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
        setupSubviews(pauseButton, startButton, resetButton, counterLabel)
        setConstraints()
        pauseButton.isEnabled = false
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

    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        self.startButton.isEnabled = false
        pauseButton.isEnabled = true
    }

    @objc private func updateTimer() {
        if secondsRemain < 1 {
            timer.invalidate()
            playSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            pauseButton.isEnabled = false
        } else {
            secondsRemain -= 1
            counterLabel.text = timeString(time: TimeInterval(secondsRemain))
        }
    }

    private func pauseTimer() {
        if self.resumeTapped == false {
            pauseButton.setTitle("Resume", for: .normal)
            timer.invalidate()
            self.resumeTapped = true
        } else {
            pauseButton.setTitle("Pause", for: .normal)
            runTimer()
            self.resumeTapped = false
        }
    }

    private func resetTimer() {
        timer.invalidate()
        secondsRemain = 5
        counterLabel.text = timeString(time: TimeInterval(secondsRemain))
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }

    private func timeString(time: CFTimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

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

    private func createButton(withTitle title: String, action: UIAction) -> UIButton {
        let button = UIButton(type:.system, primaryAction: action)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
