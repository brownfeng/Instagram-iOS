//
//  RegistrationController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: RegistratioinViewModel = RegistratioinViewModel()
    
    private var profileImage: UIImage?
    
    private lazy var plushPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    private let emailTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Email")
        return tf
    }()
    
    private let passwordTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Password")
        tf.textContentType = .oneTimeCode
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Fullname")
        return tf
    }()
    
    private let usernameTextFiled: CustomTextFiled = {
        let tf = CustomTextFiled(placeholder: "Username")
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight( 50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let haveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?  ", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    @objc private func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSignUp() {
        guard let email = emailTextFiled.text else {return}
        guard let password = passwordTextFiled.text else {return}
        guard let fullname = fullnameTextFiled.text else {return}
        guard let username = usernameTextFiled.text else {return}
        guard let profileImage = profileImage else {return}

        let credential = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(with: credential) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
            }else {
                print("DEBUG: Successfully regisetered user with firebase")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextFiled {
            viewModel.email = sender.text
        } else if sender == passwordTextFiled {
            viewModel.password = sender.text
        }else if sender == fullnameTextFiled {
            viewModel.fullname = sender.text
        }else if sender == usernameTextFiled {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.isHidden  = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view)
        plushPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plushPhotoButton.setDimensions(height: 140, width: 140)
        
        let stack = UIStackView(arrangedSubviews: [emailTextFiled, passwordTextFiled, fullnameTextFiled, usernameTextFiled, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(haveAccountButton)
        haveAccountButton.centerX(inView: view)
        haveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
    }

    func configureNotificationObsersers() {
        // 针对 textFiled 进行事件监听
        emailTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        fullnameTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        usernameTextFiled.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension RegistrationController: FormViewModel {
    func updateForm() {
        // 如何使用 viewModel
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

// MARK: -
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        profileImage = selectedImage
        
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor
        plushPhotoButton.layer.borderWidth = 2
        plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
