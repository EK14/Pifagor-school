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
}
