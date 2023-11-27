//
//  AuthService.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

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
                    "password": password
                ]) { error in
                    if let error = err {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
}
