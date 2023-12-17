//
//  MySubjectsView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 14.12.2023.
//

import UIKit

protocol mySubjectsViewDelegate: AnyObject{
    func mySubjBtnTouched()
    func elseBtnTouched()
    func addOrRemoveBtnDidTouched()
}

class MySubjectsView: UIView{
    
    private lazy var subjLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Предметы"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mySubjBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Мои", for: .normal)
        btn.setTitleColor(UIColor(named: "orange"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.addTarget(self, action: #selector(mySubjBtnDidTapped), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var elseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Ещё", for: .normal)
        btn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.addTarget(self, action: #selector(elseBtnDidTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var noSubjects: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "Предметов нет"
        label.textColor = UIColor(named: "darkGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addSubjectsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("добавить", for: .normal)
        btn.setTitleColor(UIColor(named: "orange"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.addTarget(self, action: #selector(elseBtnDidTapped), for: .touchUpInside)
        return btn
    }()
    
    var delegate: mySubjectsViewDelegate?
    var collectionView: UICollectionView! = nil
    var subjects = [String: [String]]()
    var checkState: (() -> Bool)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupCollectionView()
        setupNoSubjectsLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = UIColor(named: "lightgray")
    }
    
    private func setupConstraints(){
        addSubview(subjLabel)
        addSubview(mySubjBtn)
        addSubview(elseBtn)
        addSubview(collectionView)
        addSubview(addSubjectsBtn)
        NSLayoutConstraint.activate([
            subjLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subjLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            mySubjBtn.topAnchor.constraint(equalTo: subjLabel.bottomAnchor, constant: 20),
            mySubjBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            elseBtn.topAnchor.constraint(equalTo: subjLabel.bottomAnchor, constant: 20),
            elseBtn.leadingAnchor.constraint(equalTo: mySubjBtn.trailingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: elseBtn.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            addSubjectsBtn.topAnchor.constraint(equalTo: noSubjects.bottomAnchor),
            addSubjectsBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.estimatedItemSize = .zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MySubjectsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "lightgray")
    }
    
    private func setupNoSubjectsLabel(){
        addSubview(noSubjects)
        NSLayoutConstraint.activate([
            noSubjects.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSubjects.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        collectionView.reloadData()
    }
    
    @objc
    private func mySubjBtnDidTapped(){
        delegate?.mySubjBtnTouched()
    }
    
    @objc
    private func elseBtnDidTapped(){
        delegate?.elseBtnTouched()
    }
}

extension MySubjectsView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let res = checkState?() else {return 0}
        if res{
            if subjects["true"]?.count == 0{
                noSubjects.isHidden = false
                addSubjectsBtn.isHidden = false
                collectionView.isHidden = true
            }
            else{
                noSubjects.isHidden = true
                addSubjectsBtn.isHidden = true
                collectionView.isHidden = false
            }
            return subjects["true"]?.count ?? 0
        }
        else{
            if subjects["false"]?.count == 0{
                noSubjects.isHidden = false
                collectionView.isHidden = true
            }
            else{
                noSubjects.isHidden = true
                addSubjectsBtn.isHidden = true
                collectionView.isHidden = false
            }
            return subjects["false"]?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MySubjectsCollectionViewCell
        cell.delegate = self
        cell.setup(name: subjects["\(checkState!())"]?[indexPath.row], index: indexPath.row, state: checkState!())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 30, height: UIScreen.main.bounds.size.width/2 - 30)
    }
}

extension MySubjectsView: MySubjectsCollectionViewCellDelegate{
    func addOrRemoveBtnDidTouched(index: Int) {
        guard let state = checkState?() else {return}
        guard var reverse = subjects["\(state)"] else {return}
        subjects["\(!state)"]?.append(reverse[index])
        reverse.remove(at: index)
        subjects["\(state)"] = reverse
        collectionView.reloadData()
        AuthService.shared.updateSubjectsInformation(subjects: self.subjects)
        delegate?.addOrRemoveBtnDidTouched()
    }
}
