//
//  ViewController.swift
//  ExampleSPM
//
//  Created by Mussa Charles on 2022/10/20.
//

import UIKit
import GTProgressBar

class ViewController: UIViewController {
    
    // MARK: - Properties
    struct GraphItem {
        let fillColor: UIColor
        let progress: CGFloat
    }
    
    private let barGraphItems = [
        GraphItem(fillColor: .red, progress: 0.8),
        GraphItem(fillColor: .blue, progress: 0.3),
        GraphItem(fillColor: .green, progress: 0.5),
        GraphItem(fillColor: .yellow, progress: 0.9),
        GraphItem(fillColor: .orange, progress: 0.4),
        GraphItem(fillColor: .brown, progress: 0.7),
        GraphItem(fillColor: .purple, progress: 0.1),
        GraphItem(fillColor: .darkGray, progress: 0.9),
    ]
    
    private lazy var allBarsHStack:UIStackView = {
        let hStack = UIStackView()
        hStack.spacing = 10
        hStack.alignment = .fill
        hStack.distribution = .fill
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGraphItemsToStack()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        autoLayoutContainerView()
    }
    
    
    private func autoLayoutContainerView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.view.addSubview(self.allBarsHStack)
            
            NSLayoutConstraint.activate([
                // HStack
                self.allBarsHStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
                self.allBarsHStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
                self.allBarsHStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.allBarsHStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.allBarsHStack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2)
            ])
        }
    }
    
    private func addGraphItemsToStack() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.barGraphItems.forEach { graphItem in
                let bar = self.createVerticalProgressBar(fillColor: graphItem.fillColor, progress: graphItem.progress)
                bar.widthAnchor.constraint(equalToConstant: 20).isActive = true
                self.allBarsHStack.addArrangedSubview(bar)
            }
            // Trailing spacer
            let spacer = UIView()
            spacer.translatesAutoresizingMaskIntoConstraints = false
            self.allBarsHStack.addArrangedSubview(spacer)
        }
    }
    
}


// MARK: - Helpers

private extension ViewController {
    
    private func createVerticalProgressBar(
        fillColor: UIColor,
        progress:CGFloat
    ) -> GTProgressBar {
        let progressBar = GTProgressBar(frame: .zero)
        progressBar.progress = 0.0
        progressBar.cornerType = .topCornersOnly
        progressBar.layer.cornerRadius = 12
        
        // Colors
        progressBar.barBorderColor = UIColor.clear
        progressBar.barFillColor = fillColor
        progressBar.barBackgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        progressBar.labelTextColor = UIColor.black
        
        progressBar.barBorderWidth = 0
        progressBar.barFillInset = 0
        progressBar.displayLabel = false
        
        progressBar.direction = GTProgressBarDirection.clockwise
        progressBar.orientation = GTProgressBarOrientation.vertical
        
        progressBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            progressBar.animateTo(progress: progress,duration: 0.4)
        }
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        return progressBar
    }
}



