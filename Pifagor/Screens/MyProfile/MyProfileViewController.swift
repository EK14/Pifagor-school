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
    }
    
    private func setupNavController(){
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
    
    func setBalanceInfo(completion: @escaping () -> ()){
        myProfileView.loadData { res in
            if res{
                completion()
            }
        }
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
