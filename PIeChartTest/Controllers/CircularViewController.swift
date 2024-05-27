//
//  CircularViewController.swift
//  PieChartTest
//
//  Created by Kaue Ludovico on 27/05/24.
//

import UIKit

class CircularViewController: UIViewController {
    // MARK: - Properties
    
    var circularView: Circular!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCircularView()
    }
    
    // MARK: - Setup Circular View
    
    private func setupCircularView() {
        let percentages: [Double] = [99] // Example data percentages
        let colors: [UIColor] = [.systemBlue] // Example colors
        
        // Initialize Circular Chart view
        circularView = Circular(percentages: percentages, colors: colors)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add Circular Chart view to the main view
        view.addSubview(circularView)
        
        
        // Setup constraints for Circular Chart view
        NSLayoutConstraint.activate([
            circularView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circularView.widthAnchor.constraint(equalToConstant: 200),
            circularView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
