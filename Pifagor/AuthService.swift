//
//  AuthService.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AuthService{
    
    public static let shared = AuthService()
    
    private init(){}
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information
    ///   - completion: A completion with two values
    public func signUpUser(with userRequest: SignUpUserRequest, completion: @escaping (Bool, Error?) -> Void){
        let name = userRequest.name
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            if let error = err {
                completion(false, error)
                return
            }
            
            guard let resultUser = res?.user else{
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": name,
                    "email": email,
                    "password": password,
                ]) { error in
                    if let error = err {
                        completion(false, error)
                        return
                    }
                    self.setDefaultPhoto()
                    
                    completion(true, nil)
                }
        }
    }
    
    private func setDefaultPhoto(){
        let image = UIImage(named: "default_profile_image")
        if let imageData = image?.jpegData(compressionQuality: 0.3){
            AuthService.shared.setAvatar(image: imageData) { [weak self] res in
                if !res{
                    print("photo have not downloaded")
                }
            }
        }
    }
    
    public func signIn(with userRequest: SignInUserRequest, completion: @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { res, err in
            if let error = err{
                completion(err)
                return
            }
            else{
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void){
        do{
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    //Save Photo
    private func saveOnePhoto(image imageData: Data, uid: String, storage: StorageReference, completion: @escaping (Result<URL, Error>) -> ()){
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        DispatchQueue.main.async {
            storage.putData(imageData, metadata: metadata) { matadata, err in
                guard err == nil else {
                    completion(.failure(err!))
                    return
                }
                
                storage.downloadURL { url, err in
                    guard err == nil else {
                        completion(.failure(err!))
                        return
                    }
                    
                    if let url = url{
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
    func setAvatar(image: Data, completion: @escaping (Bool) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let path = Firestore.firestore().collection("users")
            .document(uid)
        
        let storage = Storage.storage().reference()
            .child("users")
            .child(uid)
            .child("avatarka")
        
        saveOnePhoto(image: image, uid: uid, storage: storage) { result in
            switch result{
            case .success(let url):
                path.updateData(["photoURL" : url.absoluteString])
                completion(true)
            case .failure(let err):
                print(err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func getUserData(completion: @escaping (String) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else {return}
            
            guard let document = snap?.data() else {return}
            
            let photoURL = document["photoURL"] as! String
            completion(photoURL)
        }
    }
}
