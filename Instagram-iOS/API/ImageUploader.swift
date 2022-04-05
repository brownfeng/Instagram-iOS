//
//  ImageUploader.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = UUID().uuidString
        // 上传到指定接口中
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        // 在指定路径中上传服务
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Fialed to upload image \(error.localizedDescription)")
                return
            }
            
            // 获取 download url !!!
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
