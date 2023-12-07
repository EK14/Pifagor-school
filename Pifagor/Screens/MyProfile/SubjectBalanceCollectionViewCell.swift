//
//  SubjectBalanceCollectionViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 07.12.2023.
//

import UIKit

class SubjectBalanceCollectionViewCell: UICollectionViewCell {
    
    private lazy var topupBalanceBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Пополнить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(color: UIColor){
        self.contentView.layer.cornerRadius = 30
        contentView.backgroundColor = color.withAlphaComponent(0.7)
        topupBalanceBtn.backgroundColor = color
        addSubview(topupBalanceBtn)
        NSLayoutConstraint.activate([
            topupBalanceBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            topupBalanceBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            topupBalanceBtn.widthAnchor.constraint(equalToConstant: 150),
            topupBalanceBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        alpha = 0.6
//    }
}
