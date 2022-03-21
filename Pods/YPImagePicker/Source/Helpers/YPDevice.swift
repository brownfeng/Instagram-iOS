//
//  YPHomeIndicator.swift
//  YPImagePicker
//
//  Created by 黄文飞 on 2020/4/3.
//  Copyright © 2020 Yummypets. All rights reserved.
//

import UIKit.UIDevice
import QuartzCore.CABase

public struct YPStatusBar {
    /// - Tag: iPhone
    enum iPhone: CGFloat {
        case none = 0
        case normal = 20
        case specialX = 44
    }
    /// - Tag: iPad
    enum iPad: CGFloat {
        case none = 0
        case normal = 24
    }
    static func height() -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let idiom = UIDevice.current.userInterfaceIdiom
        let isPortrait = width < height
        var statusH: CGFloat = 0
        if idiom == .phone {
            if isPortrait {
                let isSpecialX = (width == 375 && height > 667)
                              || (width == 414 && height > 736)
                if isSpecialX {
                    statusH = iPhone.specialX.rawValue
                } else {
                    statusH = iPhone.none.rawValue
                }
            } else {
                let isSpecialX = (height == 375 && width > 667)
                              || (height == 414 && width > 736)
                if isSpecialX {
                    statusH = iPhone.normal.rawValue
                } else {
                    statusH = iPhone.none.rawValue
                }
            }
        }
        if idiom == .pad {
            statusH = isPortrait ? iPad.normal.rawValue : iPad.none.rawValue
        }
        return statusH
    }
}

public struct YPHomeIndicator {
    /// - Tag: iPhone
    enum iPhone: CGFloat {
        case none = 0
        case specialXPortrait = 34
        case specialXLanscape = 21
    }
    /// - Tag: iPad
    enum iPad: CGFloat {
        case none = 0
        case portrait = 20
        case lanscape = 15
    }
    static func height() -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let idiom = UIDevice.current.userInterfaceIdiom
        let isPortrait = width < height
        var indicatorH: CGFloat = 0
        if isPortrait {
            let isSpecialX = (width == 375 && height > 667)
                          || (width == 414 && height > 736)
            if idiom == .phone, isSpecialX {
                indicatorH = iPhone.specialXPortrait.rawValue
            }
            if idiom == .pad { indicatorH = iPad.portrait.rawValue }
        } else {
            let isSpecialX = (height == 375 && width > 667)
                          || (height == 414 && width > 736)
            if idiom == .phone, isSpecialX {
                indicatorH = iPhone.specialXLanscape.rawValue
            }
            if idiom == .pad { indicatorH = iPad.lanscape.rawValue }
        }
        return indicatorH
    }
}
