//
//  FeedController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    // 这里也是 任何时候 posts 中的属性发送变化, 这里就会调用
    var posts: [Post] = [Post]() {
        // 会有一个 modify!!!!
        didSet {
            collectionView.reloadData()
        }
    }
    
    var post: Post?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        fetchPosts()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }
        
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    // MARK: - Actions
    @objc
    private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch{
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc
    func handleRefresh() {
        fetchPosts()
    }
    
    // MARK: - API
    func fetchPosts() {
        guard post == nil else {
            self.collectionView.refreshControl?.endRefreshing()
            return
        }
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()
        }
    }
    
    func checkIfUserLikedPosts() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                print("DEBUG: Post is \(post.caption) and user liked is \(didLike)")
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId}) {
                    // 触发 posts 的 didSet 方法
                    self.posts[index].didLike = didLike
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let commentVC = CommentController(post: post)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // 单项数据流的思想
    func cell(_ cell: FeedCell, didLike post: Post) {
        
        guard let tab = tabBarController as? MainTabController else {return}
        guard let user = tab.user else { return }
        
        // 触发 cell vm的didSet
        cell.viewModel?.post.didLike.toggle()
        if post.didLike {
            print("DEBUG: Unlike post here ...")
            PostService.unlikePost(post: post) { error in
//                cell.likeButton.tintColor = .black
//                cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                // 触发 cell vm的didSet

                cell.viewModel?.post.likes = post.likes - 1
            }
        } else {
            print("DEBUG: Like post here ...")
            PostService.likePost(post: post) { error in
                // 触发 cell vm的didSet
                cell.viewModel?.post.likes = post.likes + 1
//
//                cell.likeButton.tintColor = .red
//                cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                
                
                
                NotificationService.uploadNotification(toUid: post.ownerUid,
                                                       fromUser: user,
                                                       type: .like,
                                                       post: post)
            }
        }
    }
}
