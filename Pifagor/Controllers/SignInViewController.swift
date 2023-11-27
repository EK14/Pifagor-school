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
        signInView.buttonTouched = {[weak self] param in
            switch param{
            case button.SignIn:
                self?.one()
            case button.SignUp:
                self?.two()
            }}
    }
    
    override func loadView() {
        view = signInView
    }
    
    private func one(){
        print("sign in")
    }
    
    private func two(){
        print("sign up")
    }
}

