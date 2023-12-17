//
//  SubjectBalanceCollectionViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 07.12.2023.
//

import UIKit

class SubjectBalanceCollectionViewCell: UICollectionViewCell {
    
    private var balance = Int()
    
    private lazy var topupBalanceBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Пополнить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(addMoney), for: .touchUpInside)
        return btn
    }()
    
    @objc
    private func addMoney(){
        balance += 1
        amount.text = "\(self.balance) занят\(selectEnding(balance: self.balance))"
    }
    
    private lazy var subjectName: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var amount: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(color: UIColor, balance: Balance){
        self.contentView.layer.cornerRadius = 30
        self.balance = balance.balance
        contentView.backgroundColor = color.withAlphaComponent(0.7)
        topupBalanceBtn.backgroundColor = color
        subjectName.text = balance.subject
        amount.text = "\(self.balance) занят\(selectEnding(balance: self.balance))"
        subjectName.numberOfLines = 0
        addSubview(topupBalanceBtn)
        addSubview(amount)
        addSubview(subjectName)
        NSLayoutConstraint.activate([
            topupBalanceBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            topupBalanceBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            topupBalanceBtn.widthAnchor.constraint(equalToConstant: 150),
            topupBalanceBtn.heightAnchor.constraint(equalToConstant: 40),
            
            amount.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 10),
            amount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amount.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            subjectName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            subjectName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    
    private func selectEnding(balance: Int) -> String{
        if balance == 11 || balance == 12 || balance == 13 || balance == 14 || balance == 15{
            return "ий"
        } else if balance % 10 == 1{
            return "ие"
        } else if balance % 10 == 2 || balance % 10 == 3 || balance % 10 == 4{
            return "ия"
        } else{
            return "ий"
        }
    }
}
