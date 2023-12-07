//
//  MyProfileHeadView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MyProfileHeadView: UIView {
    
    var editBtnDidTouched: (() -> ())?
    
    lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = UIScreen.main.bounds.size.width*0.33/2
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var editBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(editBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    @objc
    private func editBtnDidTap(){
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = true
        editBtnDidTouched?()
//        picker.delegate = self
//        present(picker, animated: true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "lightgray")
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        addSubview(profileImage)
        addSubview(editBtn)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
            profileImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
            
            editBtn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 5),
            editBtn.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -10),
            editBtn.widthAnchor.constraint(equalToConstant: 30),
            editBtn.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
}
