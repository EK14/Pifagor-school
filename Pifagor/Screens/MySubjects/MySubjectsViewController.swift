//
//  MySubjectsViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class MySubjectsViewController: UIViewController {
    
    private var mySubjectsView = MySubjectsView()
    private var viewState = true

    override func viewDidLoad() {
        super.viewDidLoad()
        getClosuresRequests()
        mySubjectsView.delegate = self
        loadSubjData()
    }
    
    override func loadView() {
        view = mySubjectsView
    }
    
    
    private func getClosuresRequests(){
        mySubjectsView.checkState = { [weak self] in
            guard let self = self else {return false}
            return self.viewState
        }
    }
    
    private func loadSubjData(){
        AuthService.shared.getUserSubjects { [weak self] subjects in
            self?.mySubjectsView.subjects = subjects
            self?.mySubjectsView.collectionView.reloadData()
        }
    }
}

extension MySubjectsViewController: mySubjectsViewDelegate{
    func mySubjBtnTouched() {
        if !viewState{
            mySubjectsView.mySubjBtn.setTitleColor(UIColor(named: "orange"), for: .normal)
            mySubjectsView.elseBtn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
            mySubjectsView.collectionView.reloadData()
        }
        viewState = true
    }
    
    func elseBtnTouched() {
        if viewState{
            mySubjectsView.mySubjBtn.setTitleColor(UIColor(named: "darkGray"), for: .normal)
            mySubjectsView.elseBtn.setTitleColor(UIColor(named: "orange"), for: .normal)
            mySubjectsView.collectionView.reloadData()
        }
        viewState = false
    }
    
    
    
    
}
