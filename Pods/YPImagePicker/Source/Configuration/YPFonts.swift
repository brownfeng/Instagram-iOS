//
//  YPFonts.swift
//  YPImagePicker
//
//  Created by 黄文飞 on 2020/3/30.
//  Copyright © 2020 Yummypets. All rights reserved.
//

import UIKit

public struct YPFonts {
    
    // MARK: Gallery
    
    /// The font of mutil selection number of photo screen.
    public var libraryMutilSelectionNumberTextFont: UIFont = .systemFont(ofSize: 12, weight: .regular)
    
    /// A font of duration text of photo and video screens.
    public var libraryDurationTextFont: UIFont = .systemFont(ofSize: 12)
    
    // MARK: - Gallery Bottom Pager
    
    /// A color for for bottom buttons selected text.
    public var bottomMenuItemSelectedTextFont: UIFont = .systemFont(ofSize: 19, weight: .semibold)

    /// A color for for bottom buttons not selected text.
    public var bottomMenuItemUnselectedTextFont: UIFont = .systemFont(ofSize: 17, weight: .semibold)
    
    // MARK: - Gallery Albums
    
    /// Title color in the albums view cell that pops up in the library.
    public var albumCellTitleFont: UIFont = .systemFont(ofSize: 16, weight: .regular)
    /// Subtitle colors in the albums view cell that pop up in the library.
    public var albumCellNumberOfItemsTextFont: UIFont = .systemFont(ofSize: 12, weight: .regular)
    
}
