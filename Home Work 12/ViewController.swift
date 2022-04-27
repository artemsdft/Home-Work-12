//
//  ViewController.swift
//  Home Work 12
//
//  Created by Артем Дербин on 20.04.2022.
import UIKit

class ViewController: UIViewController {
    
    private lazy var viewTimer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.systemRed.cgColor
        view.layer.cornerRadius = 150
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var labelTimer: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemRed
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1.5
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 60)
        label.text = "25:00"
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var playButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play"), for: .normal)
        button.backgroundColor = .systemRed
        button.contentMode = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.contentMode = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)

        return button
    }()
    
    private var timer = Timer()
    private var workSecond = 1500
    private enum WorkingMode {
        case work, relax
    }

    private var workingMode: WorkingMode = .work
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        playButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }

    private func setupHierarchy() {
        view.addSubview(viewTimer)
        viewTimer.addSubview(labelTimer)
        viewTimer.addSubview(playButton)
        viewTimer.addSubview(pauseButton)
                
    }

    private func setupLayout() {
        viewTimer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        viewTimer.heightAnchor.constraint(equalToConstant: 300).isActive = true
        viewTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.leadingAnchor.constraint(equalTo: viewTimer.leadingAnchor, constant: 85).isActive = true
        playButton.bottomAnchor.constraint(equalTo: viewTimer.bottomAnchor, constant: -45).isActive = true
        
        pauseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pauseButton.trailingAnchor.constraint(equalTo: viewTimer.trailingAnchor, constant: -85).isActive = true
        pauseButton.bottomAnchor.constraint(equalTo: viewTimer.bottomAnchor, constant: -45).isActive = true

        labelTimer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        labelTimer.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelTimer.topAnchor.constraint(equalTo: viewTimer.topAnchor, constant: 50).isActive = true
        labelTimer.leadingAnchor.constraint(equalTo: viewTimer.leadingAnchor, constant: 45).isActive = true
        labelTimer.trailingAnchor.constraint(equalTo: viewTimer.trailingAnchor, constant: -45).isActive = true
    }
    
    @objc private func buttonAction() {
        if workingMode == .work {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workTimer), userInfo: nil, repeats: true)
        }
        if workingMode == .relax {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workTimer), userInfo: nil, repeats: true)
        }
    }

    @objc private func pauseAction() {
        timer.invalidate()
    }
    
    @objc private func workTimer() {
            workSecond -= 1
            let minutes = workSecond / 60
            let seconds = workSecond % 60
            labelTimer.text = "\(minutes):\(seconds)"
            timerMode()
    }
    
    private func timerMode() {
        if workSecond == 0 && workingMode == .work {
            workSecond = 300
            workingMode = .relax
            viewTimer.layer.borderColor = UIColor.green.cgColor
            labelTimer.backgroundColor = .systemGreen
            playButton.backgroundColor = .systemGreen
            pauseButton.backgroundColor = .systemGreen
        }
        if workSecond == 0 && workingMode == .relax {
            workSecond = 1500
            workingMode = .work
            viewTimer.layer.borderColor = UIColor.systemRed.cgColor
            labelTimer.backgroundColor = .systemRed
            playButton.backgroundColor = .systemRed
            pauseButton.backgroundColor = .systemRed
        }
    }
    
}


