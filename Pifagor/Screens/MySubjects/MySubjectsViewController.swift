//
//  MySubjectsViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class MySubjectsViewController: UIViewController {
    
    private let mySubjectsView = MySubjectsView()
    private var viewState = true

    override func viewDidLoad() {
        super.viewDidLoad()
        mySubjectsView.delegate = self
    }
    
    override func loadView() {
        view = mySubjectsView
    }
}

extension MySubjectsViewController: mySubjectsViewDelegate{
    func mySubjBtnTouched() {
        if !viewState{
            mySubjectsView.mySubjBtn.setTitleColor(UIColor(named: "orange"), for: .normal)
            mySubjectsView.elseBtn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
        }
        viewState = true
    }
    
    func elseBtnTouched() {
        if viewState{
            mySubjectsView.mySubjBtn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
            mySubjectsView.elseBtn.setTitleColor(UIColor(named: "orange"), for: .normal)
        }
        viewState = false
    }
    
    
}
