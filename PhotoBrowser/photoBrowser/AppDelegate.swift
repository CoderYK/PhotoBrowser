//
//  AppDelegate.swift
//  photoBrowser
//
//  Created by yk on 16/6/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }

}

// MARK:- 根据图片计算 imageView 的 frame
func calculateImageViewFrame(image: UIImage) -> CGRect {

    let imageViewW = UIScreen.mainScreen().bounds.width
    let imageViewH = imageViewW / image.size.width * image.size.height
    let x : CGFloat = 0
    let y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
    
    return CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
}