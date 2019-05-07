//
//  WKWebView+TYSnapshotScroll.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView{

    func screenSnapshotWKWebView(_ finishBlock:@escaping TYSnapshotScrollFinishBlock) {
        //获取父view
        var superview:UIView = UIView.init()
        let currentViewController = UIViewController.currentViewController()
        if currentViewController != nil{
            superview = (currentViewController?.view)!
        }else{
            superview = self.superview!
        }

        //添加遮盖
        let snapShotView = superview.snapshotView(afterScreenUpdates: true)
        snapShotView?.frame = CGRect(x: superview.frame.origin.x, y: superview.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)

        superview.addSubview(snapShotView!)

        //保存原始信息
        let oldFrame:CGRect = self.frame
        let oldOffset : CGPoint = self.scrollView.contentOffset
        let contentSize : CGSize = self.scrollView.contentSize

        //计算快照屏幕数
        let snapshotScreenCount = floorf(Float((contentSize.height / self.scrollView.bounds.size.height)))

        //设置frame为contentSize
        self.frame = CGRect(x: 0.0, y: 0.0, width: contentSize.width, height: contentSize.height)

        self.scrollView.contentOffset = .zero

        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)

        //截取完所有图片
        self.scrollToDraw(0, Int(snapshotScreenCount)) { [weak self] in
            snapShotView?.removeFromSuperview()
            let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self?.frame = oldFrame
            self?.scrollView.contentOffset = oldOffset

            finishBlock(snapshotImage!)

        }

    }

    func scrollToDraw(_ index:Int,_ maxIndex:Int,_ finishBlock:@escaping () -> Void) {
        let snapshotView:UIView = self.superview!

        //截取的frame
        let snapshotFrame : CGRect = CGRect(x: 0.0, y: CGFloat(index) * snapshotView.bounds.size.height, width: snapshotView.bounds.size.width, height: snapshotView.bounds.size.height)

        // set up webview originY
        var myFrame : CGRect = self.frame
        myFrame.origin.y = -(CGFloat(index) * snapshotView.frame.size.height)
        self.frame = myFrame

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {

            snapshotView.drawHierarchy(in: snapshotFrame, afterScreenUpdates: true)

            if(index < maxIndex){
                self.scrollToDraw(index + 1, maxIndex, finishBlock)
            }else{
                finishBlock()
            }
        }

    }
}

