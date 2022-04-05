//
//  LoginViewModel.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

// 使用登录服务需要用的 viewModel
protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

// 登录使用的 VC
struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.systemPurple : UIColor.systemPurple.withAlphaComponent(0.4)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1.0, alpha: 0.67)
    }
}

// 注册使用的 view/vc 使用的 viewModel
struct RegistratioinViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.systemPurple : UIColor.systemPurple.withAlphaComponent(0.4)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1.0, alpha: 0.67)
    }
}
