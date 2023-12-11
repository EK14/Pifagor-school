//
//  UILabel.swift
//  Pifagor
//
//  Created by Элина Карапетян on 11.12.2023.
//

import Foundation
import UIKit

extension UILabel {
    func addLeading(image: UIImage?) {
        guard let image = image else {
            print("Error")
            return
        }
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: " \(self.text!)", attributes: [:])

        string.insert(attachmentString, at: 0)
        self.attributedText = string
    }
}
