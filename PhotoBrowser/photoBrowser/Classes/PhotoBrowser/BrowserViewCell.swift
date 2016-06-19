//
//  BrowserViewCell.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit
import SDWebImage

class BrowserViewCell: UICollectionViewCell {
    // MARK:- 定义属性
    var shop : Shop? {
        didSet {
            // 1.空值校验
            guard let shop = shop else {
                return
            }
            
            // 2.取出 Image 对象
            var image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(shop.q_pic_url)
            if image == nil {
                image = UIImage(named: "empty_picture")
            }
            
            // 3.根据图片计算 imageView 的大小
            imageView.frame = calculateImageViewFrame(image)
            
            // 4.设置 imageView 的图片
            guard let url = NSURL(string: shop.z_pic_url) else {
                imageView.image = image
                return
            }
            
            imageView.sd_setImageWithURL(url, placeholderImage: image) { (image, _, _, _) in
                //重新计算图片的尺寸
                self.imageView.frame = self.calculateImageViewFrame(image)
            }
        }
    }
    
    // MARK:- 懒加载属性
    lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    //required: 如果有实现父类的某一个构造函数,那么必须同时实现使用required修饰的构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.addSubview(imageView)
    }
    
}

// MARK:- 根据图片计算 imageView 的 frame
extension BrowserViewCell {
    func calculateImageViewFrame(image: UIImage) -> CGRect {
        
        let imageViewW = UIScreen.mainScreen().bounds.width
        let imageViewH = imageViewW / image.size.width * image.size.height
        let x : CGFloat = 0
        let y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
        
        return CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
    }
}