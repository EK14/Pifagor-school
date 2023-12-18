//
//  MyProfileView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MyProfileView: UIView {
    
    let myProfileHeadView = MyProfileHeadView()
    
    private let cellColors = ["orange", "blue", "purple", "green"]
    var balance: [Balance] = []
    
    private lazy var noSubjects: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "Предметов нет"
        label.textColor = UIColor(named: "darkGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        noSubjects.isHidden = true
        self.setupCollectionView()
        loadData { res in
            if res{
                self.setupBackgroundColor()
                self.setupConstraints()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(completion: @escaping (Bool) -> ()){
        AuthService.shared.getUserSubjects { res in
            guard let res = res["true"] else { return }
            var buffer = [Balance]()
            for x in res{
                buffer.append(contentsOf: [Balance(balance: 0, subject: x)])
            }
            self.balance = buffer
            self.collectionView.reloadData()
            completion(true)
        }
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        myProfileHeadView.translatesAutoresizingMaskIntoConstraints = false
        myProfileHeadView.layer.cornerRadius = 40
        myProfileHeadView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        addSubview(headerTitle)
        addSubview(collectionView)
        addSubview(myProfileHeadView)
        addSubview(noSubjects)
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: myProfileHeadView.bottomAnchor, constant: 20),
            headerTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            myProfileHeadView.topAnchor.constraint(equalTo: topAnchor),
            myProfileHeadView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myProfileHeadView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            noSubjects.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSubjects.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 200)
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
        noSubjects.isHidden = balance.count == 0 ? false: true
        return balance.count
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
