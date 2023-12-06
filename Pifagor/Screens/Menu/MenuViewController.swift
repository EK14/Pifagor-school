//
//  MenuViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let menuView = MenuView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = menuView
    }
}

//navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(didTapLogout))
//
//@objc
//private func didTapLogout(){
//    AuthService.shared.signOut { [weak self] err in
//        guard let self = self else {return}
//        if let err = err {
//            AlertManager.shared.callAlert(error: err)
//            return
//        }
//        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
//            sceneDelegate.checkAuth()
//        }
//    }
//}
