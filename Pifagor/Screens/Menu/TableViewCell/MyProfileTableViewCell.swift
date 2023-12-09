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
    
    lazy var myProfileBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Личный кабинет >", for: .normal)
        btn.setTitleColor(UIColor(named: "orange"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setCell(){
        AuthService.shared.getUserData(completion: { photoURL in
            self.profileImage.sd_setImage(with: URL(string: photoURL))
        }, field: "photoURL")
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSubview(profileImage)
//        addSubview(name)
//        addSubview(studentLabel)
//        addSubview(myProfileBtn)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIViewController().topbarHeight),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            profileImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
            profileImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.33),
        ])
    }
}

