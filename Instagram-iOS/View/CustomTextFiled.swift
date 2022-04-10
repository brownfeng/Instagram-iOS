//
//  CustomTextFiled.swift
//  Instagram-iOS
//
//  Created by brown on 2022/3/20.
//

import Foundation
import UIKit

class CustomTextFiled: UITextField {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    init(placeholder: String) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always

        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha:  0.1)
        setHeight(50) // 默认只有一个 导读约束
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1.0, alpha: 0.7)])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
