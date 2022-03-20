//
//  LoginController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    private let iconImage:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight( 50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
    private let forgotPasswordutton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help Signing in.")
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?  ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObsersers()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @objc private func handleShowSignUp() {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextFiled {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden  = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top:view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextFiled, passwordTextFiled, loginButton, forgotPasswordutton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObsersers() {
        emailTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        // 如何使用 viewModel
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}
