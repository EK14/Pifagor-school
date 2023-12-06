//
//  MyProfileView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit

class MyProfileView: UIView {
    
    private let myProfileHeadView = MyProfileHeadView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*0.4))

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(myProfileHeadView)
        setupBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
}
