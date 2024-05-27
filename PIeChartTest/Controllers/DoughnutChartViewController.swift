//
//  ViewController.swift
//  PIeChartTest
//
//  Created by Kaue Ludovico on 27/05/24.
//

import UIKit

class DoughnutChartViewController: UIViewController {
    
    // MARK: - Properties
    
    var circularView: DoughnutChartCircular!
    
    lazy var infoChart: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCircularView()
    }
    
    // MARK: - Setup Circular View
    
    private func setupCircularView() {
        let percentages: [Double] = [80] // Example data percentages
        let colors: [UIColor] = [.systemBlue] // Example colors
        
        // Initialize Doughnut Chart view
        circularView = DoughnutChartCircular(percentages: percentages, colors: colors)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add Doughnut Chart view to the main view
        view.addSubview(circularView)
        
        // Setup constraints for Doughnut Chart view
        NSLayoutConstraint.activate([
            circularView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circularView.widthAnchor.constraint(equalToConstant: 200),
            circularView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

