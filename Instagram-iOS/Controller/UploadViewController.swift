//
//  UploadViewController.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/5.
//

import UIKit


protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadViewController)
}

class UploadViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: UploadPostControllerDelegate?
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet {
            photoimageView.image = selectedImage
        }
    }
    
    private let photoimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Actions
    
    @objc
    func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapDone() {
        guard let image = selectedImage else {return}
        guard let caption = captionTextView.text else {return}
        guard let currentUser = currentUser else {
            return
        }
        showLoader(true)
        PostService.uploadPost(caption: caption, image: image, user: currentUser) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
                return
            }
            
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        
        view.addSubview(photoimageView)
        photoimageView.setDimensions(height: 180, width: 180)
        photoimageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoimageView.centerX(inView: view)
        photoimageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoimageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
     
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: captionTextView.rightAnchor, paddingBottom: -8, paddingRight: 12)
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}

// MARK: - UITextViewDelegate

extension UploadViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
