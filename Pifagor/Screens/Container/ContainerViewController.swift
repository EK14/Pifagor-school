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
    private let back = MenuBackground(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
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
        myProfileVC.view.addSubview(back)
        back.isHidden = true
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
                UIView.transition(with: self.back, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.back.isHidden = false
                })
                self.navVC?.view.frame.origin.x = self.myProfileVC.view.frame.size.width - 100
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                UIView.transition(with: self.back, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.back.isHidden = true
                })
                self.navVC?.view.frame.origin.x = 0
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                }
            }
        }
    }
}
