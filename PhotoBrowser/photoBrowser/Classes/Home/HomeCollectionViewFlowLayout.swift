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
        
        let itemW = (UIScreen.mainScreen().bounds.size.width - margin * 4) / 3
        
        itemSize = CGSize(width: itemW, height: itemW)
        
        // 设置间距
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        
        // 设置内边距
        collectionView?.contentInset = UIEdgeInsetsMake(margin + 64, margin, margin, margin)
    }

}
