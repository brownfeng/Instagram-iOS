//
//  NotificationCell.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/10.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    static let identifier: String = "NotificationCell"
    
    // MARK: - Properties
    
    var viewModel: NotificationViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "venom-7")
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "venom"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "venom-7")
        iv.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var followButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Loading", for: .normal)
        bt.layer.cornerRadius = 3
        bt.layer.borderWidth = 0.5
        bt.layer.borderColor = UIColor.lightGray.cgColor
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.setTitleColor(.black, for: .normal)
        bt.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return bt
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        
        
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: 12, width: 100, height: 32)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 40, height: 40)
        
        followButton.isHidden = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc
    func handleFollowTapped() {
        
    }
    
    @objc
    func handlePostTapped() {
        
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else {return}
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageUrl)
        
        infoLabel.attributedText = viewModel.notificationMessage
        
    }
    
    
}
