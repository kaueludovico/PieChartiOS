//
//  InfoChart.swift
//  PieChartTest
//
//  Created by Kaue Ludovico on 27/05/24.
//

import SwiftUI

class InfoChart: UIView {
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0099D5")
        return label
    }()
    
    lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0099D5")
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#0099D5")
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(percentage: String, weekDay: String, date: String) {
        percentageLabel.text = percentage
        weekDayLabel.text = weekDay
        dateLabel.text = date
    }
    
    func addViews() {
        addSubview(percentageLabel)
        addSubview(weekDayLabel)
        addSubview(dateLabel)
    }
    
    func setupConstraints() {
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            percentageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            percentageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            
            weekDayLabel.topAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 8),
            weekDayLabel.leadingAnchor.constraint(equalTo: percentageLabel.leadingAnchor),
            weekDayLabel.trailingAnchor.constraint(equalTo: percentageLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: weekDayLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: weekDayLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: weekDayLabel.trailingAnchor)
        ])
    }
}
