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
        getClosuresRequests()
    }
    
    override func loadView() {
        view = menuView
    }
    
    private func getClosuresRequests(){
        menuView.logoutBtnDidTouched = {[weak self] in self?.logoutBtnDidTap()}
    }
    
    private func logoutBtnDidTap(){
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
    
    func didChangedPhoto(){
        menuView.menuTableView.reloadData()
    }
}

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
