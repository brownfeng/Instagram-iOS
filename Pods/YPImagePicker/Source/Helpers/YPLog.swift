//
//  YPLog.swift
//  YPImagePicker
//
//  Created by 黄文飞 on 2020/3/31.
//  Copyright © 2020 Yummypets. All rights reserved.
//

import Foundation

struct YPLog {
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            print(items, separator: separator, terminator: terminator)
        #endif
    }
        
    static func print<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream {
        #if DEBUG
            print(items, separator: separator, terminator: terminator, to: &output)
        #endif
    }
    
}
