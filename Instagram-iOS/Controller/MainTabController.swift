//
//  MainTabController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import FirebaseAuth
import UIKit
import YPImagePicker

class MainTabController: UITabBarController {
    
    var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            configureViewControllers(withUser: user)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLogggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    func checkIfUserIsLogggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    // MARK: - Helpers
    
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        delegate = self

        // 注意是 flowlayout 而不是 layout
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: "home_unselected", selectedImage: "home_selected", rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: "search_unselected", selectedImage: "search_selected", rootViewController: SearchController())
        let imageSelector = templateNavigationController(unselectedImage: "plus_unselected", selectedImage: "plus_unselected", rootViewController: ImageSelectorController())
        let notifications = templateNavigationController(unselectedImage: "like_unselected", selectedImage: "like_selected", rootViewController: NotificationController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: "profile_unselected", selectedImage: "profile_selected", rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: String, selectedImage: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image =  UIImage(named: unselectedImage)
        nav.tabBarItem.selectedImage =  UIImage(named: selectedImage)
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    // 设置回调方法
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                print("DEBUG: Selected image is \(selectedImage)")
                let controller = UploadViewController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }
}

// MARK : - AuthenticationDelegate

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
//        if index == 2 {
//            let controller = UINavigationController(rootViewController: UploadViewController())
//            controller.modalPresentationStyle = .fullScreen
//            present(controller, animated: true)
//            return false
//        }
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.hidesStatusBar = false
            config.hidesStatusBar = false
            config.screens = [.library]
            config.library.maxNumberOfItems = 1
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
            // 设置 Picker的回调方法
            didFinishPickingMedia(picker)
        }
        return true
    }
}

// MARK: - UploadPostControllerDelegate

extension MainTabController: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadViewController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else {return }
        feed.handleRefresh()
    }
}
