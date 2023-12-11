//
//  ScheduleNestedView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 11.12.2023.
//

import UIKit

class ScheduleNestedView: UIView {
    
    private let schedule = ["Понедельник": [Schedule(subject: "Художественная мастерская", teacher: "Калмыкова Диана", startTime: 9),
                            Schedule(subject: "Подготовка к школе", teacher: "Алексеев Матвей", startTime: 10),
                            Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11),
                            Schedule(subject: "Логопед и развитие речи", teacher: "Комиссарова Елизавета", startTime: 12),
                            Schedule(subject: "Математика", teacher: "Прокофьева Василиса", startTime: 13),
                            Schedule(subject: "Математика", teacher: "Прокофьева Василиса", startTime: 13)],
                            "Вторник": [Schedule(subject: "Художественная мастерская", teacher: "Калмыкова Диана", startTime: 9),
                            Schedule(subject: "Подготовка к школе", teacher: "Алексеев Матвей", startTime: 10),
                            Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11)]]
    
    var currentDay = String()
    
    private var collectionView: UICollectionView! = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "lightgray")
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 40
        layer.masksToBounds = true
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(){
        //Schedule collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ScheduleNestedCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.layer.borderColor = .none
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}

extension ScheduleNestedView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        schedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleNestedCollectionViewCell
        cell.setCell(index: indexPath.row, sub: schedule[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width, height: bounds.size.height / 5)
    }
    
}
