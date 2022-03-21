//
//  YPColors.swift
//  YPImagePicker
//
//  Created by Nik Kov || nik-kov.com on 13.04.2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

public struct YPColors {
    
    // MARK: - Common
    
    /// The common tint color which is used for done buttons in navigation bar, multiple items selection and so on.
    public var tintColor = UIColor.ypSystemBlue
    
    /// The common tint color which is used for cancle buttons in navigation bar.
    public var cancelTintColor: UIColor = .ypLabel
    
    /// A color for navigation bar spinner.
    /// Default is nil, which is default iOS gray UIActivityIndicator.
    public var navigationBarActivityIndicatorColor: UIColor?
    
    /// A color for circle for selected items in multiple selection
    /// Default is nil, which takes tintColor.
    public var multipleItemsSelectedCircleColor: UIColor?

    /// A color for circle for unselected items in multiple selection
    public var multipleItemsUnSelectedCircleColor: UIColor = .white
    
    /// The background color of the bottom of photo and video screens.
    public var photoVideoScreenBackgroundColor: UIColor = .offWhiteOrBlack

    /// The background color of the library and space between collection view cells.
    public var libraryScreenBackgroundColor: UIColor = .offWhiteOrBlack
    
    /// The color of the line between the asset container and the library.
    public var libraryScreenLineColor: UIColor = .ypSystemBackground
    
    /// A color of duration text of photo and video screens.
    public var libraryDurationTextColor: UIColor = .white
    
    /// The color of mutil selection number of photo screen.
    public var libraryMutilSelectionNumberTextColor: UIColor = .white
    
    ///The color of the selection overlay of photo screen.
    public var librarySelectionOverlayColor: UIColor = .offWhiteOrBlack

    /// The background color of safe area. For example under the menu items.
    public var safeAreaBackgroundColor: UIColor = .offWhiteOrBlack

    /// A color for background of the asset container. You can see it when bouncing the image.
    public var assetViewBackgroundColor: UIColor = .offWhiteOrBlack
    
    /// A color for background in filters.
    public var filterBackgroundColor: UIColor = .offWhiteOrBlack

    /// A color for background in selections gallery. When multiple items selected.
    public var selectionsBackgroundColor: UIColor = .offWhiteOrBlack

    /// - Tag: Gallery Albums
    /// Library pops up the background color of the albums view.
    public var albumViewBackgroundColor: UIColor = .ypSystemBackground
    
    /// Spinner color in the albums view that pops up in the library.
    public var albumSpinnerColor: UIColor?
    
    /// Title color in the albums view cell that pops up in the library.
    public var albumCellTitleColor: UIColor = .ypLabel
    
    /// Subtitle colors in the albums view cell that pop up in the library.
    public var albumCellNumberOfItemsColor: UIColor = .ypLabel
    
    /// - Tag: Gallery Bottom Pager
    /// A color of bottom menu.
    public var bottomMenuBackgroundColor: UIColor = .offWhiteOrBlack
    
    /// A color of bottom menu's header.
    public var bottomMenuHeaderBackgroundColor: UIColor = .offWhiteOrBlack
    
    /// A color of bottom menu's scroll view.
    public var bottomMenuScrollViewBackgroundColor: UIColor = .offWhiteOrBlack
    
    /// A color for bottom buttons (photo, video, all photos).
    public var bottomMenuItemBackgroundColor: UIColor = .clear

    /// A color for for bottom buttons selected text.
    public var bottomMenuItemSelectedTextColor: UIColor = .ypLabel

    /// A color for for bottom buttons not selected text.
    public var bottomMenuItemUnselectedTextColor: UIColor = .ypSecondaryLabel

    // MARK: - Trimmer
    
    /// The color of the main border of the view
    public var trimmerMainColor: UIColor = .ypLabel
    /// The color of the handles on the side of the view
    public var trimmerHandleColor: UIColor = .ypSystemBackground
    /// The color of the position indicator
    public var positionLineColor: UIColor = .ypSystemBackground
    
    // MARK: - Cover selector
    
    /// The color of the cover selector border
    public var coverSelectorBorderColor: UIColor = .offWhiteOrBlack
    
    // MARK: - Progress bar
    
    /// The color for the progress bar when processing video or images. The all track color.
    public var progressBarTrackColor: UIColor = .ypSystemBackground
    /// The color of completed track for the progress bar
    public var progressBarCompletedColor: UIColor?
    
    // MARK: - Filters
    
    /// - Tag: Crop
    
    /// A background color of crop view.
    public var cropBackgroundColor: UIColor = .ypSystemBackground
    
    /// A background color of crop curtain view.
    public var cropCurtainBackgroundColor: UIColor = .ypSystemBackground
    
}
