//
//  ScheduleViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    private let scheduleView = ScheduleView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func loadView() {
        view = scheduleView
    }

}
