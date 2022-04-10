//
//  CommentController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/5.
//

import UIKit

private let reuseIdentifier = "Cell"

class CommentController: UICollectionViewController {
    
    // MARK: - Properties
    private let post: Post
    private var comments = [Comment]()
    
    // 键盘伴随控件, 需要默认高度
    private lazy var commentInputView: CommentInputAccesoryView = {
        // 设置的高度, 最小的约束是 50
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    // just for text
//    private lazy var myKBView: CustomKeyboardView = {
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
//        let view = CustomKeyboardView(frame: frame)
//        return view
//    }()
//
    /// 测试 inputView 和 inputAccessoryView
//    override var inputView: UIView? {
//        get {
//            super.inputView
//            return myKBView
//        }
//    }

    // MARK: - Lifecycle
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return commentInputView
        }
    }
    
    // 变成一个基础的服务
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - API
    
    func fetchComments() {
        CommentService.fetchComment(forPost: post.postId) {[weak self] comments in
            self?.comments = comments
            self?.collectionView.reloadData()
        }
    }

    // MARK: - Helpers
    func configureCollectionView() {
        navigationItem.title = "Comments"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
        collectionView.alwaysBounceVertical = true
        // collectionView 滚动时, 是否能与 keyboard交互
        collectionView.keyboardDismissMode = .interactive
        collectionView.backgroundColor = .white
    }
}

// MARK: - UICollectionViewDataSource
extension CommentController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // adjustedContentInset 会随着 "InputView(键盘) + InputAccessoryView 变化"
        debugPrint(scrollView.adjustedContentInset)
    }
    
}

// MARK: - UICOllectionViewDelegateFlowLayout

extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension CommentController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        guard let tab = self.tabBarController as? MainTabController else {
            return
        }
        
        guard let user = tab.user else { return }
        
        self.showLoader(true)
        CommentService.uploadComment(comment: comment, postId: post.postId, user: user) { error in
            self.showLoader(false)
            
            inputView.clearCommentTextView()
        }
    }
}
