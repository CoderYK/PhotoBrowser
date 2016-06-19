//
//  HomeViewController.swift
//  photoBrowser
//
//  Created by yk on 16/6/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    // MARK:- 定义的属性
    lazy var shops : [Shop] = [Shop]()
    lazy var animateManager : AnimateManager = AnimateManager()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加载数据
        loadData(0)
    }
    
}

// MARK:- 网络请求的方法
extension HomeViewController {
    func loadData(offset : Int) {
        // 发送网络请求
        HttpManager.shareInstance.loadHomeData(offset) {(resultArray, error) in
            // 1.空值校验
            if error != nil {
                return
            }
            
            // 2.取出可选类型中的数据
            guard let resultArray = resultArray else {
                return
            }
            
            // 3.遍历数组,将数组中的字典转成模型对象
            for dict in resultArray {
                let shop = Shop(dict: dict)
                self.shops.append(shop)
            }
            
            // 4.刷新表格
            self.collectionView?.reloadData()
        }
    }
}


// MARK:- 实现collectionView 数据源函数
extension HomeViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shops.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建 Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeViewCell
        
        // 2.给 Cell 设置数据
        cell.shop = self.shops[indexPath.row]
        
        // 3.判断是否是最后一个 Cell 出现
        if indexPath.row == self.shops.count - 1 {
            loadData(shops.count)
        }
        
        return cell
    }
}


// MARK:- 实现代理方法,监听 Cell 的点击
extension HomeViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //创建图片浏览控制器
        let browserVc = BrowserViewController()
        
        // 设置控制器属性
        browserVc.indexPath = indexPath
        browserVc.shops = shops
        
        // 设置 browser 的 modal动画
        browserVc.modalPresentationStyle = .Custom
        browserVc.transitioningDelegate = animateManager
        
        // 弹出控制器
        presentViewController(browserVc, animated: true, completion: nil)
    }
}





