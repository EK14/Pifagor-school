//
//  SceneDelegate.swift
//  Pifagor
//
//  Created by Элина Карапетян on 25.10.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.setupWindow(with: scene)
        checkAuth()
        
    }
    
    private func setupWindow(with scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    public func checkAuth(){
        if Auth.auth().currentUser == nil{
            self.goToController(with: SignInViewController())
        }else{
            self.goToController(with: HomeViewController())
        }
    }
    
    private func goToController(with viewController: UIViewController){
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
                
            }
        }
    }
}

