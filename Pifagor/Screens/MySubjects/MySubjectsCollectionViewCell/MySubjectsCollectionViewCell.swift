//
//  MySubjectsCollectionViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 14.12.2023.
//

import UIKit

protocol MySubjectsCollectionViewCellDelegate: AnyObject{
    func addOrRemoveBtnDidTouched(index: Int)
}

class MySubjectsCollectionViewCell: UICollectionViewCell {
    
    private let colors = ["orange", "blue", "purple", "green"]
    var delegate: MySubjectsCollectionViewCellDelegate?
    private var index = Int()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.alpha = 0.9
        img.contentMode = .center
        img.tintColor = .black
        img.layer.cornerRadius = (contentView.bounds.width / 3) / 2
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var addOrRemoveBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "lightgray")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = (contentView.bounds.width / 4) / 2
        btn.addTarget(self, action: #selector(addOrRemoveBtnDidTouched), for: .touchUpInside)
        return btn
    }()
    
    func setup(name: String?, index: Int, state: Bool){
        guard let name = name else {return}
        self.index = index
        nameLabel.text = name
        img.backgroundColor = UIColor(named: colors[index % colors.count])
        backgroundColor = .white
        layer.cornerRadius = 20
        setupConstraints()
        setImage(name: name)
        if state{
            addOrRemoveBtn.setImage(UIImage(systemName: "minus"), for: .normal)
        }
        else{
            addOrRemoveBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        }
    }
    
    private func setupConstraints(){
        addSubview(nameLabel)
        addSubview(img)
        addSubview(addOrRemoveBtn)
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            img.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            img.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            img.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3 ),
            img.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            
            addOrRemoveBtn.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            addOrRemoveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addOrRemoveBtn.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 4),
            addOrRemoveBtn.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 4),
            
        ])
    }
    
    private func setImage(name: String){
        var systemName = String()
        switch name{
        case "Художественная мастерская":
            systemName = "paintbrush.pointed"
        case "Английский язык":
            systemName = "abc"
        case "Логопед и развитие речи":
            systemName = "mouth"
        case "Программирование":
            systemName = "laptopcomputer"
        case "Математика":
            systemName = "textformat.123"
        case "Подготовка к школе":
            systemName = "backpack"
        default:
            systemName = "questionmark"
        }
        img.image = UIImage(systemName: systemName)
    }
    
    @objc
    private func addOrRemoveBtnDidTouched(){
        delegate?.addOrRemoveBtnDidTouched(index: self.index)
    }
}
