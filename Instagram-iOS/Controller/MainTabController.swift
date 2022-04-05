//
//  MainTabController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import FirebaseAuth
import UIKit

class MainTabController: UITabBarController {
    
    private var user: User? {
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
}

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
