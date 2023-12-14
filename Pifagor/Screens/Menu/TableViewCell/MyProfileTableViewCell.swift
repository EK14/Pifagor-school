//
//  MyProfileTableViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 09.12.2023.
//

import UIKit
import SDWebImage

class MyProfileTableViewCell: UITableViewCell {
    
    lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = UIScreen.main.bounds.size.width*0.33/2
        img.clipsToBounds = true
        return img
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.text = " "
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var studentLabel: UILabel = {
        let studentLabel = UILabel()
        studentLabel.text = "ученик"
        studentLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        studentLabel.translatesAutoresizingMaskIntoConstraints = false
        return studentLabel
    }()
    
    lazy var myProfile: UILabel = {
        let label = UILabel()
        label.text = "Личный кабинет >"
        label.textColor = UIColor(named: "orange")
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setCell(){
        AuthService.shared.getUserData(completion: { photoURL in
            self.profileImage.sd_setImage(with: URL(string: photoURL))
        }, field: "photoURL")
        
        AuthService.shared.getUserData(completion: { name in
            self.name.text = name
        }, field: "username")
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSubview(profileImage)
        addSubview(name)
        addSubview(studentLabel)
        addSubview(myProfile)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            profileImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
            profileImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
            
            name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            name.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            
            studentLabel.topAnchor.constraint(equalTo: name.bottomAnchor),
            studentLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            
            myProfile.topAnchor.constraint(equalTo: studentLabel.bottomAnchor, constant: 15),
            myProfile.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            myProfile.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

