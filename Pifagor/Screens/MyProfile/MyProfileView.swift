//
//  MyProfileView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MyProfileView: UIView {
    
    let myProfileHeadView = MyProfileHeadView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*0.4))
    
    private let cellColors = ["orange", "blue", "purple", "green"]
    var balance: [Balance] = []
    
    private lazy var headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Баланс занятий"
        title.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var collectionView: UICollectionView! = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(myProfileHeadView)
        setupBackgroundColor()
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        addSubview(headerTitle)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: myProfileHeadView.bottomAnchor, constant: 20),
            headerTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubjectBalanceCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MyProfileView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        balance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectBalanceCollectionViewCell
        let color = UIColor(named: cellColors[indexPath.row % cellColors.count]) ?? .white
        cell.setCell(color: color, balance: balance[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.size.width - 40, height: (UIScreen.main.bounds.size.height*0.4)/3 )
    }
}
