//
//  ScheduleNestedView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 11.12.2023.
//

import UIKit

protocol BoundingWidthAdoptable {
    func adoptBoundingWidth(_ width: CGFloat)
}

class ScheduleNestedView: UIView {
    
    private lazy var noSchedule: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "Занятий нет"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schedule = [[Schedule(subject: "Подготовка к школе", teacher: "Алексеев Матвей", startTime: 10),
                            Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11)],
                            [Schedule(subject: "Художественная мастерская", teacher: "Калмыкова Диана", startTime: 9),
                            Schedule(subject: "Подготовка к школе", teacher: "Алексеев Матвей", startTime: 10),
                             Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11),
                             Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11),
                             Schedule(subject: "Английский язык", teacher: "Масленникова Мия", startTime: 11)], [], [], [], [], []]
    
    var currentDay = 0
    
    var collectionView: UICollectionView! = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "lightgray")
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 40
        layer.masksToBounds = true
        setupCollectionView()
        setupNoScheduleLabel()
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
    
    private func setupNoScheduleLabel(){
        noSchedule.isHidden = true
        addSubview(noSchedule)
        NSLayoutConstraint.activate([
            noSchedule.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSchedule.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

extension ScheduleNestedView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if schedule[currentDay].count == 0{
            collectionView.isHidden = true
            noSchedule.isHidden = false
        }
        else{
            collectionView.isHidden = false
            noSchedule.isHidden = true
        }
        return schedule[currentDay].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleNestedCollectionViewCell
        if indexPath.row == schedule[currentDay].count - 1{
            cell.thelast = true
        }
        cell.setCell(index: indexPath.row, sub: schedule[currentDay][indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width, height: 130)
    }

    
    
    
}
