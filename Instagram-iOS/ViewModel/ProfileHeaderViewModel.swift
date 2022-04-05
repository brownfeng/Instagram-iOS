//
//  ProfileViewModel.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/30.
//

import Foundation
import UIKit

// ViewModel 是一个 View 关联的模型, 最好的方式是 一个 Protocol
struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit profile"
        }else {
            return user.isFollowed ? "Following" : " Follow"
        }
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    
    var numberOfFollowers: NSAttributedString {
        return  attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return  attributedStatText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return  attributedStatText(value: 5, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attrText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attrText
    }
}
