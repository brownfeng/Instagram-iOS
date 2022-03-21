//
//  AuthService.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit
import FirebaseCore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage

}

struct AuthService {
    static func registerUser(with credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        print(credentials)
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {
                    return
                }
                
                let data: [String: Any] = [
                    "email": credentials.email,
                    "fullname": credentials.fullname,
                    "profileImageUrl": imageUrl,
                    "uid": uid,
                    "username": credentials.username
                ]
                
                
                
            }
        }
    }
}
