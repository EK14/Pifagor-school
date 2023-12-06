//
//  MenuView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MenuView: UIView {
    
    var logoutBtnDidTouched: (() -> ())?
    
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Выйти", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(logoutBtnDidTap), for: .touchUpInside)

        return btn
    }()
    
    @objc
    private func logoutBtnDidTap(){
        logoutBtnDidTouched?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        addSubview(logoutBtn)
        NSLayoutConstraint.activate([
            logoutBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            logoutBtn.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50)
        ])
    }
}
