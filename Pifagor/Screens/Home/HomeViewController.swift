//
//  HomeViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    
    @objc
    private func didTapLogout(){
        
        AuthService.shared.signOut { [weak self] err in
            guard let self = self else {return}
            if let err = err {
                print(err.localizedDescription)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuth()
            }
        }
    }
}
