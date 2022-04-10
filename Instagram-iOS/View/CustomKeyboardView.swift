//
//  CustomKeyboardView.swift
//  Instagram-iOS
//
//  Created by brown on 2022/4/10.
//

import Foundation
import UIKit

class CustomKeyboardView: UIView {
    
    private let bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        backgroundColor = .green
        
        addSubview(bgView)
        bgView.anchor(top:topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 66)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return .zero
        }
    }
}
