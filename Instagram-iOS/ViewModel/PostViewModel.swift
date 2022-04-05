//
//  FeedCellViewModel.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/5.
//

import Foundation

// 针对某个模型的 ViewModel 服务
struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl)}
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var username: String { return post.ownerUsername }
    
    var caption: String { return post.caption}
    
    var likes: Int { return post.likes }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
        
    }
    
    init(post: Post) {
        self.post = post
    }
}
