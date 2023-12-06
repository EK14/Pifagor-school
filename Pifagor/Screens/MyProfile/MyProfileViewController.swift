//
//  MyProfileViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

protocol MyProfileViewControllerDelegate: AnyObject{
    func didTapMenu()
}

class MyProfileViewController: UIViewController {
    
    private let myProfileView = MyProfileView()
    weak var delegate: MyProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "list.dash")
        item.style = .plain
        item.target = self
        item.action = #selector(didTapMenu)
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
    }
    
    override func loadView() {
        view = myProfileView
    }
    
    @objc
    private func didTapMenu(){
        delegate?.didTapMenu()
    }

}
