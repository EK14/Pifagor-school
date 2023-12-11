//
//  WeekDayCollectionViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setCell(name: String){
        label.text = name
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .white : .black
        }
    }
}
