//
//  HomeCollectionViewFlowLayout.swift
//  photoBrowser
//
//  Created by yk on 16/6/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class HomeCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        // 自定义布局信息
        
        let margin : CGFloat = 10
        
        let itemWH = (UIScreen.mainScreen().bounds.width - 4 * margin ) / 3
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        
        // 设置间距
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        
        // 设置内边距
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64 , left: margin, bottom: margin, right: margin)
    }

}
