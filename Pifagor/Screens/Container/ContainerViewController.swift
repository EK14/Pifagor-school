//
//  HomeViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState{
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    private let myProfileVC = MyProfileViewController()
    private let menuVC = MenuViewController()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addChildVCs()
    }
    
    private func addChildVCs(){
        //Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //MyProfile
        myProfileVC.delegate = self
        let nav = UINavigationController(rootViewController: myProfileVC)
        addChild(nav)
        view.addSubview(nav.view)
        nav.didMove(toParent: self)
        self.navVC = nav
    }
    
}

extension ContainerViewController: MyProfileViewControllerDelegate{
    func didTapMenu() {
        switch menuState{
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.myProfileVC.view.frame.size.width - 100
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = 0
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                }
            }
        }
    }
}
