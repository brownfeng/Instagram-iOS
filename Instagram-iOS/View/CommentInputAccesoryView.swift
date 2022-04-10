//
//  CommentInputAccesoryView.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/9.
//

import Foundation
import UIKit
protocol CommentInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String)
}

// 自定义输入伴随控件
// 作为 inputAccessoryView 使用
class CommentInputAccesoryView: UIView {
    
    // MARK: - Properties
    weak var delegate: CommentInputAccesoryViewDelegate?
    
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeholderShouldCenter = true
        return tv
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        debugPrint(frame)
        // 当前的 CommentInputAccesoryView 使用的是 autoresizingMask!!
        // 当使用 autoresizeMask 以后
        autoresizingMask = [.flexibleHeight]
        
        backgroundColor = .white
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.placeholderText = "Enter Comment..."
        commentTextView.backgroundColor = .green
        // comment的内容 中 bottom 关联的是  safeAreaLayoutGuide.bottomAnchor!!!
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        // 上半部分划线
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 1)
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .red
        addSubview(bottomDivider)
        // 下半部分划线
        bottomDivider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Warning: 将这个固有属性设置成-1 非常重要!!!
    // 并且在键盘操作使用中会调用非常多次!!! 因此很多第三方服务写的时, 需要增加缓存
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Actions
    
    @objc
    func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    // MARK: - Helpers
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
}
