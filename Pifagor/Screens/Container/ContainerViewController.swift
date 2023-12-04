//
//  HomeViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AlertManager.shared.presentAlert = {[weak self] error in self?.present(error, animated: true)}
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(didTapLogout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(didTapMenu))
    }
    
    @objc
    private func didTapLogout(){
        AuthService.shared.signOut { [weak self] err in
            guard let self = self else {return}
            if let err = err {
                AlertManager.shared.callAlert(error: err)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuth()
            }
        }
    }
    
    @objc
    private func didTapMenu(){
        print("Прыветы")
    }
}