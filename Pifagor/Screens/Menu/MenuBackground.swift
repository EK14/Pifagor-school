//
//  MenuBackground.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MenuBackground: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "menubackground")
        alpha = 0.7
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
