//
//  BrowserViewController.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {

    // MARK:- 定义的属性
    var indexPath : NSIndexPath?
    var shops : [Shop]?
    let browserCellID = "browserCellID"
    
    
    // MARK:- 懒加载的属性
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: BrowserViewFlowLayout())
    lazy var cloceBtn : UIButton = UIButton()
    lazy var saveBtn : UIButton = UIButton()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BrowserViewController {
    
    func setupUI() {
        
        // 添加子控件
        view.addSubview(collectionView)
        view.addSubview(cloceBtn)
        view.addSubview(saveBtn)
        
        // 布局子控件
        collectionView.frame = view.bounds
        let margin : CGFloat = 20.0
        let btnW : CGFloat = 90
        let btnH : CGFloat = 32
        let y = UIScreen.mainScreen().bounds.height - margin - btnH
        cloceBtn.frame = CGRect(x: margin, y: y, width: btnW, height: btnH)
        let x = UIScreen.mainScreen().bounds.width - margin - btnW
        saveBtn.frame = CGRect(x: x, y: y, width: btnW, height: btnH)
        
        // 设置 btn 相关属性
        prepareBtn()
        
        // 设置 collectionView 的相关属性
        prepareCollcetionView()
    }
    
    func prepareBtn() {
        setupBtn(cloceBtn, title: "关 闭", action: "closeBtnClick")
        setupBtn(saveBtn, title: "保 存", action: "saveBtnClick")
    }
    
    func setupBtn(btn : UIButton, title: String, action: String) {
        btn.setTitle(title, forState: . Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        btn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        // 监听按钮点击 参数:Selector 1.Selector("方法名称") 2."方法名称"
        btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
    }
    
    func prepareCollcetionView() {
        collectionView.dataSource = self
        // 注册 Cell  获取某一个类的 class :UICollectionView.self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: browserCellID)
    }
}

// MARK:- 监听事件
extension BrowserViewController {

    /*
    监听事件本质:发送消息
        1.发送消息的过程:1.将方法包装称 SEL, 2.到类的方法列表中找到对应的方法 3.找到 IMP的函数指针 4.执行函数
        2.在 Swift 中,如果一个函数被 private 修饰,那么该方法不糊被放到方法列表中
        3.只有在 private 前面加上@objc,那么该方法就会被放到方法列表中
     */
    
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClick() {
        print("保存图片")
    }
}

// MARK:- collectionView的数据源和代理方法
extension BrowserViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建 Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(browserCellID, forIndexPath: indexPath)
        
        // 2.设置 Cell 的数据
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blueColor() : UIColor.redColor()
        
        return cell
    }
}






