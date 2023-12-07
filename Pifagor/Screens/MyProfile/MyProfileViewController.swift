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
}

class MyProfileViewController: UIViewController {
    
    let myProfileView = MyProfileView()
    weak var delegate: MyProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProfileView.myProfileHeadView.editBtnDidTouched = {[weak self]  in
            self?.editBtnDidTouched()
        }
        updateAvatar()
        title = "Личный кабинет"
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "list.dash")
        item.style = .plain
        item.target = self
        item.action = #selector(didTapMenu)
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
    }
    
    override func loadView() {
        view = myProfileView
    }
    
    @objc
    private func didTapMenu(){
        delegate?.didTapMenu()
    }
    
    private func editBtnDidTouched(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
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
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
    
    func updateAvatar(){
        AuthService.shared.getUserData { photoURL in
            self.myProfileView.myProfileHeadView.profileImage.sd_setImage(with: URL(string: photoURL))
        }
    }
}
