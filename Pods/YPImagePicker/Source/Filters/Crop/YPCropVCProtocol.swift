//
//  YPCropVCProtocol.swift
//  YPImagePicker
//
//  Created by 黄文飞 on 2020/4/1.
//  Copyright © 2020 Yummypets. All rights reserved.
//

import UIKit

public protocol YPCropVCProtocol where Self: UIViewController {
    var didFinishCropping: ((UIImage) -> Void)? { set get }
    init(image: UIImage, configuration: Any?)
}

public class YPAnyCropVC: UIViewController, YPCropVCProtocol {
    
    public let originalImage: UIImage
    public var didFinishCropping: ((UIImage) -> Void)?
    
    override public var prefersStatusBarHidden: Bool { return YPConfig.hidesStatusBar }
    
    public required init(image: UIImage, configuration: Any?) {
        originalImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard YPConfig.hidesNavigationBarBackground else { return }
        let isHide = !YPConfig.hidesNavigationBarBackground
        navigationController?.setNavigationBarHidden(isHide, animated: true)
    }
    
}
