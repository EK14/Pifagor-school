//
//  MyProfileViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 06.12.2023.
//

import UIKit
import SDWebImage

protocol MyProfileViewControllerDelegate: AnyObject{
    func didTapMenu()
    func didChangedPhoto()
}

class MyProfileViewController: UIViewController {
    
    let myProfileView = MyProfileView()
    weak var delegate: MyProfileViewControllerDelegate?
    private let balance = [Balance(balance: 1, subject: "Математика"), Balance(balance: 5, subject: "Художественная мастерская"), Balance(balance: 2, subject: "Английский язык"), Balance(balance: 8, subject: "Логопед и развитие речи")]

    override func viewDidLoad() {
        super.viewDidLoad()
        getClosuresRequests()
        updateAvatar()
        setupNavController()
        setBalanceInfo()
    }
    
    override func loadView() {
        view = myProfileView
    }
    
    @objc
    private func didTapMenu(){
        delegate?.didTapMenu()
    }
    
    private func getClosuresRequests(){
        myProfileView.myProfileHeadView.editBtnDidTouched = {[weak self]  in
            self?.editBtnDidTouched()
        }
        
        AuthService.shared.getUserData(completion: { [weak self] name in
            guard name == name else {return}
            self?.myProfileView.myProfileHeadView.name.text = name
        }, field: "username")

        AuthService.shared.getUserData(completion: { email in
            guard email == email else {return}
            let text = NSMutableAttributedString.init(string: "Электронная почта: \(email)")
            text.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)],
                               range: NSMakeRange(0, "Электронная почта:".count))
            text.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .thin)], range: NSMakeRange("Электронная почта:".count+1, email.count))
            self.myProfileView.myProfileHeadView.emailLabel.attributedText = text
        }, field: "email")
        
    }
    
    private func setupNavController(){
        title = "Личный кабинет"
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "list.dash")
        item.style = .plain
        item.target = self
        item.action = #selector(didTapMenu)
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
    }
    
    private func editBtnDidTouched(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setBalanceInfo(){
        myProfileView.balance = balance
    }

}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage{
            self.myProfileView.myProfileHeadView.profileImage.image = image
            
            if let imageData = image.jpegData(compressionQuality: 0.3){
                AuthService.shared.setAvatar(image: imageData) { res in
                    if res{
                        self.updateAvatar()
                        self.delegate?.didChangedPhoto()
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
    
    func updateAvatar(){
        AuthService.shared.getUserData(completion: { photoURL in
            self.myProfileView.myProfileHeadView.profileImage.sd_setImage(with: URL(string: photoURL))
        }, field: "photoURL")
    }
    
}
