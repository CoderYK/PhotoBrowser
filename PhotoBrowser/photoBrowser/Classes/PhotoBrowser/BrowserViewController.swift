//
//  BrowserViewController.swift
//  photoBrowser
//
//  Created by yk on 16/6/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        // 0.设置图片之间的间距
        view.frame.size.width += 10
        
        // 1.设置 UI
        setupUI()
        
        // 2.滚动到对应的位置
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
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
        collectionView.registerClass(BrowserViewCell.self, forCellWithReuseIdentifier: browserCellID)
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
        // 1.取出当前正在显示的图片
        let cell = collectionView.visibleCells().first as! BrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2.保存图片
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    @objc private func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            SVProgressHUD.showErrorWithStatus("保存失败")
            return
        }
        
        SVProgressHUD.showSuccessWithStatus("保存成功")
    }
}

// MARK:- collectionView的数据源和代理方法
extension BrowserViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops?.count ?? 0    //可选链中 ?? 的作用:如果可选链中没有值,那么直接使用??后面的值
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建 Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(browserCellID, forIndexPath: indexPath) as! BrowserViewCell
        
        // 2.设置 Cell 的数据
        cell.shop = shops![indexPath.item]
        
        return cell
    }
}


// MARK:- 实现
extension BrowserViewController : DismissProtocol {
    
    func getImageView() -> UIImageView {
        // 1.创建 imageView 对象
        let imageView = UIImageView()
        
        // 2.设置 imageView 的 Image
        let cell = collectionView.visibleCells().first as! BrowserViewCell
        imageView.image = cell.imageView.image
        
        // 3.设置 imageView 的 frame
        imageView.frame = cell.imageView.frame
        
        // 4.设置 imageView 的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func getIndexPath() -> NSIndexPath {
        // 1.获取正在显示的 Cell
        let cell = collectionView.visibleCells().first as! BrowserViewCell
        
        return collectionView.indexPathForCell(cell)!
        
    }
}





