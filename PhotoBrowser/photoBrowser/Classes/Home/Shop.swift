//
//  Shop.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class Shop: NSObject {
    
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    // 容错处理
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
