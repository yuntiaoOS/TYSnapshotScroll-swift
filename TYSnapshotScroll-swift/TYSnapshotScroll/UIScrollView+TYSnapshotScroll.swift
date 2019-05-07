//
//  UIScrollView+TYSnapshotScroll.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit
import Foundation

extension UIScrollView{
    func screenSnapshotScrollView(_ finishBlock:@escaping  TYSnapshotScrollFinishBlock) {

        var snapshotImage:UIImage?

        //保存offset
        let oldContentOffset :CGPoint = self.contentOffset
        //保存frame
        let oldFrame : CGRect = self.frame

        if (self.contentSize.height > self.frame.size.height) {
            self.contentOffset = CGPoint(x: 0.0, y: self.contentSize.height - self.frame.size.height)
        }
        self.frame = CGRect(x: 0.0, y: 0.0, width: self.contentSize.width, height: self.contentSize.height)

        //延迟0.3秒，避免有时候渲染不出来的情况
        Thread.sleep(forTimeInterval: 0.3)

        self.contentOffset = .zero

        UIGraphicsBeginImageContextWithOptions(self.bounds.size,false,UIScreen.main.scale)

        let context = UIGraphicsGetCurrentContext()

        self.layer.render(in: context!)

        //        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO]

        snapshotImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()


        self.frame = oldFrame
        //还原
        self.contentOffset = oldContentOffset

        if (snapshotImage != nil) {
            finishBlock(snapshotImage!)
        }

    }

    func screenSnapshotWithSnapshotView(_ snapshotView:UIView,_ snapshotSize:CGSize = .zero) -> UIImage {
        var snapshotImage:UIImage = UIImage.init()


        var snapshotViewSize = snapshotSize

        if (snapshotSize.height == 0 || snapshotSize.width == 0) {//宽高为0的时候没有意义
            snapshotViewSize = snapshotView.bounds.size
        }

        //创建
        UIGraphicsBeginImageContextWithOptions(snapshotViewSize, false, UIScreen.main.scale)

        let context = UIGraphicsGetCurrentContext()

        snapshotView.layer.render(in: context!)
        //        [snapshotView drawViewHierarchyInRect:snapshotView.bounds afterScreenUpdates:NO]

        //获取图片
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext()!

        //关闭
        UIGraphicsEndImageContext()

        return snapshotImage
    }
}

