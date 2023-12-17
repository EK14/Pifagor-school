//
//  ScheduleViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    private let scheduleView = ScheduleView()
    private var schedule = [[Schedule]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = scheduleView
    }
    
    func loadData(){
        scheduleView.scheduleNestedView.loadData { res in
            if res{
                self.scheduleView.scheduleNestedView.collectionView.reloadData()
            }
        }
    }
}
