//
//  CommentViewModel.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/10.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var commentLableText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.font: UIFont.systemFont(ofSize: 14)])

        attributedString.append(NSAttributedString(string: comment.commentText, attributes: [.font : UIFont.systemFont(ofSize: 14)]))
        
        return attributedString
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

}
