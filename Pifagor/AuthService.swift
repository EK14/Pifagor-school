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
        let subjects = userRequest.subjects
        
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
                    "subjects": subjects
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
            AuthService.shared.setAvatar(image: imageData) { res in
                if !res{
                    print("photo have not downloaded")
                }
            }
        }
    }
    
    public func signIn(with userRequest: SignInUserRequest, completion: @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { res, err in
            if let error = err{
                completion(error)
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
    
    func getUserData(completion: @escaping (String) -> (), field: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else {return}
            
            guard let document = snap?.data() else {return}
            
            let data = document[field] as! String
            completion(data)
        }
    }
    
    func getScheduleData() async throws -> [[Schedule]]{
        let weekDays = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
        let db = Firestore.firestore()
        var data = [[Schedule]]()
        
        for x in 0...(weekDays.count-1){
            let snap = try await db.collection("schedule").document("standart").collection(weekDays[x]).getDocuments()
            data.append([])
            for document in snap.documents{
                let schedule = try document.data(as: Schedule.self)
                data[x].append(schedule)
            }
            data[x].sort()
        }
        return data
    }
    
    func getUserSubjects(completion: @escaping ([String: [String]]) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else {return}
            
            guard let document = snap?.data() else {return}
            
            let data = document["subjects"] as! [String: [String]]
            completion(data)
        }
    }
    
    func updateSubjectsInformation(subjects: [String: [String]]){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .updateData([
                "subjects": subjects
            ])
    }
    
    func setupPersonalSchedule(allSubjects: [[Schedule]], completion: @escaping ([[Schedule]]) -> Void) {
        self.getUserSubjects { [weak self] res in
            guard let _ = self, let res = res["true"] else { return }
            var mySchedule = [[Schedule]]()
            
            for x in 0...(allSubjects.count-1) {
                mySchedule.append([])
                if (allSubjects[x].count > 0) {
                    for y in 0...(allSubjects[x].count-1) {
                        if (res.contains(allSubjects[x][y].subject)) {
                            mySchedule[x].append(allSubjects[x][y])
                        }
                    }
                }
            }
            
            completion(mySchedule)
        }
    }

}
