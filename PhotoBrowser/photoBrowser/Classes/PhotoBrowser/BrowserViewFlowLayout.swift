//
//  BrowserViewFlowLayout.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class BrowserViewFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        //设置 layout 相关属性
        itemSize = UIScreen.mainScreen().bounds.size
        scrollDirection = .Horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        //设置 collectionView 相关属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        
    }
}
