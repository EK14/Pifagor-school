//
//  MenuView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MenuView: UIView {
    
    var logoutBtnDidTouched: (() -> ())?
    var didSelect: ((MenuOptions) -> ())?
    
    var photoURL = String()
    
    enum MenuOptions: String, CaseIterable{
        case myProfile = "Личный кабинет"
        case schedule = "Расписание"
        case mySubjects = "Мои предметы"
        case homework = "Домашнее задание"
        case aboutUs = "О нас"
        
        var imageName: String {
            switch self{
            case .myProfile:
                return ""
            case .schedule:
                return "calendar.badge.clock"
            case .mySubjects:
                return "folder"
            case .homework:
                return "doc"
            case .aboutUs:
                return "person.3"
            }
        }
    }
    
    let menuTableView = UITableView()
    
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Выйти", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(logoutBtnDidTap), for: .touchUpInside)

        return btn
    }()
    
    @objc
    private func logoutBtnDidTap(){
        logoutBtnDidTouched?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupTableView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        addSubview(logoutBtn)
        addSubview(menuTableView)
        NSLayoutConstraint.activate([
            logoutBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            logoutBtn.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            
            menuTableView.topAnchor.constraint(equalTo: topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            menuTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: logoutBtn.topAnchor)
        ])
    }
    
    private func setupTableView(){
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: "myProfileCell")
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
}

extension MenuView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "myProfileCell", for: indexPath) as! MyProfileTableViewCell
            cell.setCell()
            cell.selectionStyle = .none
            return cell
        default:
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
            cell.selectionStyle = .none
            cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
//            cell.imageView?.frame = CGRectMake(0,0,10,10)
            cell.tintColor = .black
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return UIScreen.main.bounds.size.height*0.31
        default:
            return UIScreen.main.bounds.size.height*0.08
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(MenuOptions.allCases[indexPath.row])
    }
    
    
}
