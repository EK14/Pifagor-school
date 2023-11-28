//
//  AlertManager.swift
//  Pifagor
//
//  Created by Элина Карапетян on 28.11.2023.
//

import UIKit


class AlertManager{
    
    public static let shared = AlertManager()
    var presentAlert: ((UIAlertController) -> ())?
    
    private init(){}
    
    func callAlert(error: Error){
        let errorAlert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(okBtn)
        presentAlert?(errorAlert)
    }
    
}
