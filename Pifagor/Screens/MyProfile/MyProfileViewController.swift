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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(didTapMenu))
    }
    
    override func loadView() {
        view = myProfileView
    }
    
    @objc
    private func didTapMenu(){
        delegate?.didTapMenu()
    }

}
