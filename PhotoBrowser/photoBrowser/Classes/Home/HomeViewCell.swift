//
//  HomeViewCell.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var shop : Shop? {
        didSet {
            // 1.校验模式是否有值
            guard let shop = shop else {
                return
            }
            
            // 2.取出图片的 urlString
            guard let url = NSURL(string: shop.q_pic_url) else {
                return
            }
            
            // 3.设置图片
            let placeHolderImage = UIImage(named: "empty_picture")
            imageView.sd_setImageWithURL(url, placeholderImage: placeHolderImage)
            
        }
    }
    
    
    
}
