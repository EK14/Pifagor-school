//
//  MySubjectsView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 14.12.2023.
//

import UIKit

protocol mySubjectsViewDelegate: AnyObject{
    func mySubjBtnTouched()
    func elseBtnTouched()
}

class MySubjectsView: UIView {
    
    private lazy var subjLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Предметы"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mySubjBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Мои", for: .normal)
        btn.setTitleColor(UIColor(named: "orange"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.addTarget(self, action: #selector(mySubjBtnDidTapped), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var elseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Ещё", for: .normal)
        btn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.addTarget(self, action: #selector(elseBtnDidTapped), for: .touchUpInside)
        return btn
    }()
    
    var delegate: mySubjectsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = UIColor(named: "lightgray")
    }
    
    private func setupConstraints(){
        addSubview(subjLabel)
        addSubview(mySubjBtn)
        addSubview(elseBtn)
        NSLayoutConstraint.activate([
            subjLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subjLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            mySubjBtn.topAnchor.constraint(equalTo: subjLabel.bottomAnchor, constant: 20),
            mySubjBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            elseBtn.topAnchor.constraint(equalTo: subjLabel.bottomAnchor, constant: 20),
            elseBtn.leadingAnchor.constraint(equalTo: mySubjBtn.trailingAnchor, constant: 20),
        ])
    }
    
    @objc
    private func mySubjBtnDidTapped(){
        delegate?.mySubjBtnTouched()
    }
    
    @objc
    private func elseBtnDidTapped(){
        delegate?.elseBtnTouched()
    }
}
