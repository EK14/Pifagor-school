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
    }
    
    override func loadView() {
        view = signInView
    }

}

