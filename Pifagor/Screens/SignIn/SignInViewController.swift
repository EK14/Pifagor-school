//
//  ViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 25.10.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInView = SignInView()

    override func viewDidLoad() {
        super.viewDidLoad()
        AlertManager.shared.presentAlert = {[weak self] error in self?.present(error, animated: true)}
        signInView.buttonTouched = {[weak self] param, email, password in
            switch param{
            case button.SignIn:
                self?.signIn(email: email, password: password)
            case button.SignUp:
                self?.two()
            }}
    }
    
    override func loadView() {
        view = signInView
    }
    
    private func signIn(email: String, password: String){
        if email == ""{
            callAlert(error: MyError.noEmailError)
            return
        }
        if password == "" {
            callAlert(error: MyError.noPasswordError)
            return
        }
        let userRequest = SignInUserRequest(email: email, password: password)
        AuthService.shared.signIn(with: userRequest) { [self] err in
            if let error = err{
                callAlert(error: error)
                return
            }
            else{
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                    sceneDelegate.checkAuth()
                }
            }
        }
    }
    
    private func two(){
        print("sign up")
    }
    
    func callAlert(error: Error){
        AlertManager.shared.callAlert(error: error)
    }
}

