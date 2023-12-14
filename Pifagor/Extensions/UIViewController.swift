//
//  UIViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 10.12.2023.
//

import Foundation
import UIKit

extension UIViewController {

    /// Calculate top distance with "navigationBar" and "statusBar" by adding a
     /// subview constraint to navigationBar or to topAnchor or superview
     /// - Returns: The real distance between topViewController and Bottom navigationBar
     func calculateTopDistance()-> CGFloat{
         print((navigationController?.toolbar.superview?.frame.size.height))
         return  UIApplication.shared.statusBarFrame.size.height +
         (navigationController?.navigationBar.frame.height ?? 0.0)
         
     }
}
