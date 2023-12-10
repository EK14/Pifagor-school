//
//  UIViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import Foundation
import UIKit

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
