//
//  YPBottomPagerView.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 24/01/2018.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import UIKit
import Stevia

final class YPBottomPagerView: UIView {
    
    var header = YPPagerMenu()
    var scrollView = UIScrollView()
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = YPConfig.colors.bottomMenuBackgroundColor
        
        sv(
            scrollView,
            header
        )
        
        layout(
            0,
            |scrollView|,
            0,
            |header| ~ 44
        )
        
        setHeaderBottom()
        hideHeader(isHide: YPConfig.hidesBottomBar)
        
        clipsToBounds = false
        setupScrollView()
    }

    private func setupScrollView() {
        scrollView.clipsToBounds = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.backgroundColor = YPConfig.colors.bottomMenuScrollViewBackgroundColor
    }
    
    private func setHeaderBottom() {
        if #available(iOS 11.0, *) {
            let offset = -(safeAreaInsets.bottom) + YPHomeIndicator.height()
            let value = YPConfig.hidesBottomBar ? 0 : offset
            header.bottom(value)
        } else {
            header.bottom(0)
        }
    }
    
    public func hideHeader(isHide: Bool) {
        header.heightConstraint?.constant = isHide ? 0 : 44
        headerBottomOffset(isHide: isHide)
    }
    
    public func headerBottomOffset(isHide: Bool) {
        guard !YPConfig.hidesBottomBar else { return }
        guard !YPConfig.onlySquareImagesFromCamera else { return }
        guard YPConfig.hidesBottomBarWhenSelectedCamareScreen else { return }
        if #available(iOS 11.0, *) {
            header.bottomConstraint?.constant = isHide ? 0 : -(safeAreaInsets.bottom)
//            UIView.animate(withDuration: 0.2) { self.layoutIfNeeded() }
        } else {
            header.bottomConstraint?.constant = 0
        }
    }
}
