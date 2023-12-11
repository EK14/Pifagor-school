//
//  ScheduleView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class ScheduleView: UIView {
    
    private let dayOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскрсенье"]
    private let shortDayOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private var select = 0
    
    private let scheduleNestedView = ScheduleNestedView()
    
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = dayOfWeek[0]
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dayOfWeekcollectionView: UICollectionView! = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupCollectionViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        addSubview(dayOfWeekLabel)
        addSubview(dayOfWeekcollectionView)
        addSubview(scheduleNestedView)
        NSLayoutConstraint.activate([
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dayOfWeekLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            dayOfWeekcollectionView.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 10),
            dayOfWeekcollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dayOfWeekcollectionView.heightAnchor.constraint(equalToConstant: 70),
            dayOfWeekcollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            scheduleNestedView.topAnchor.constraint(equalTo: dayOfWeekcollectionView.bottomAnchor, constant: 20),
            scheduleNestedView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scheduleNestedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scheduleNestedView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupCollectionViews(){
        //Pic a day of the week
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        
        dayOfWeekcollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dayOfWeekcollectionView.dataSource = self
        dayOfWeekcollectionView.delegate = self
        dayOfWeekcollectionView.showsHorizontalScrollIndicator = false
        dayOfWeekcollectionView.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekcollectionView.register(WeekDayCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        dayOfWeekcollectionView.allowsMultipleSelection = false
    }
}

extension ScheduleView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dayOfWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayOfWeekcollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeekDayCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.setCell(name: shortDayOfWeek[indexPath.row])
        if (indexPath.row == select){
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
            cell.backgroundColor = UIColor(named: "orange")
        }else{
            cell.backgroundColor = UIColor(named: "lightgray")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(named: "orange")
        dayOfWeekLabel.text = dayOfWeek[indexPath.row]
        select = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        cell?.backgroundColor = UIColor(named: "lightgray")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

