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
    private let homeworkVC = HomeworkViewController()
    private let mySubjectsVC = MySubjectsViewController()
    private let aboutUsVC = AboutUsViewController()
    private let scheduleVC = ScheduleViewController()
    private let back = MenuBackground(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addChildVCs()
    }
    
    private func addChildVCs(){
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //MyProfile
        myProfileVC.delegate = self
        myProfileVC.view.addSubview(back)
        back.isHidden = true
        myProfileVC.title = "Личный кабинет"
        let nav = UINavigationController(rootViewController: myProfileVC)
        addChild(nav)
        view.addSubview(nav.view)
        nav.didMove(toParent: self)
        self.navVC = nav
    }
    
}

extension ContainerViewController: MyProfileViewControllerDelegate, MenuViewControllerDelegate{
    func didSelect(screen: MenuView.MenuOptions) {
        toggleMenu(completion: nil)
        switch screen{
        case .myProfile:
            self.resetToMyProfile()
        case .schedule:
            self.addInfo(screen: screen)
        case .mySubjects:
            self.addInfo(screen: screen)
        case .homework:
            self.addInfo(screen: screen)
        case .aboutUs:
            self.addInfo(screen: screen)
        }
    }
    
    func addInfo(screen: MenuView.MenuOptions){
        var vc = UIViewController()
        switch screen{
        case .schedule:
            vc = scheduleVC
        case .mySubjects:
            vc = mySubjectsVC
        case .homework:
            vc = homeworkVC
        case .aboutUs:
            vc = aboutUsVC
        default:
            break
        }
        vc.view.addSubview(back)
        myProfileVC.title = screen.rawValue
        myProfileVC.addChild(vc)
        myProfileVC.view.addSubview(vc.view)
        vc.didMove(toParent: myProfileVC)
    }
    
    func resetToMyProfile(){
        mySubjectsVC.view.removeFromSuperview()
        mySubjectsVC.didMove(toParent: nil)
        scheduleVC.view.removeFromSuperview()
        scheduleVC.didMove(toParent: nil)
        aboutUsVC.view.removeFromSuperview()
        aboutUsVC.didMove(toParent: nil)
        homeworkVC.view.removeFromSuperview()
        homeworkVC.didMove(toParent: nil)
        myProfileVC.title = "Личный кабинет"
        myProfileVC.view.addSubview(back)
    }
    
    func didChangedPhoto() {
        menuVC.didChangedPhoto()
    }
    
    func didTapMenu(){
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?){
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
            UIView.transition(with: self.back, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.back.isHidden = true
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                    self.navVC?.view.frame.origin.x = 0
                }completion: { [weak self] done in
                    if done{
                        self?.menuState = .closed
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                }
            })
        }
    }
}
