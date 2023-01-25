//
//  TimerViewController.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//
import AVFoundation
import AudioToolbox
import UIKit

final class TimerViewController: UIViewController {

    private var audioPlayer: AVAudioPlayer?
    private var timer = Timer()
    private var secondsRemain = 10

    private var soundEnabled = true
    private var isTimerRunning = false
    private var resumeTapped = false
    
    private let timerProgressView = TimerProgressView(
        frame: CGRect(x: 0.0, y: 0.0, width: 160, height: 160)
    )
    
    private lazy var timerButton: UIButton = {
        createTimerButton(action: UIAction { [unowned self] _ in
            pauseTimer()
        })
    }()

    private lazy var resetButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = timeString(time: TimeInterval(secondsRemain))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(resetButton, counterLabel, timerProgressView, timerButton)
        setConstraints()
        
        setProgressView()
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        if secondsRemain < 1 {
            timer.invalidate()
            playSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            secondsRemain -= 1
            counterLabel.text = timeString(time: TimeInterval(secondsRemain))
        }
    }

    private func pauseTimer() {
        if self.resumeTapped == false {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .regular, scale: .large)
            let image = UIImage(systemName: "play.fill", withConfiguration: imageConfig)
            timerButton.setImage(image, for: .normal)
            timer.invalidate()
            self.resumeTapped = true
        } else {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .regular, scale: .large)
            let image = UIImage(systemName: "pause.fill", withConfiguration: imageConfig)
            timerButton.setImage(image, for: .normal)
            runTimer()
            self.resumeTapped = false
        }
    }

    @objc private func resetTimer() {
        timer.invalidate()
        secondsRemain = 10
        counterLabel.text = timeString(time: TimeInterval(secondsRemain))
    }

    private func timeString(time: CFTimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format:"%02i:%02i", minutes, seconds)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }

    private func createTimerButton(action: UIAction) -> UIButton {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .regular, scale: .large)
        let image = UIImage(systemName: "play.fill", withConfiguration: imageConfig)

        let button = UIButton(type: .custom, primaryAction: action)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
                        
    private func setProgressView() {
        timerProgressView.progressColor = UIColor.systemGreen
        timerProgressView.center = self.view.center
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270)
        ])

        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: timerProgressView.bottomAnchor, constant: 40),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


