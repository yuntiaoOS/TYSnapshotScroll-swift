//
//  TYSnapshotScroll.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit
import WebKit

typealias TYSnapshotScrollFinishBlock = (_ snapShotImage:UIImage) -> Void

class TYSnapshotScroll: NSObject {

    class func screenSnapshot(_ snapshotView:UIView,_ finishBlock:@escaping TYSnapshotScrollFinishBlock) {

        var snapshotFinalView = snapshotView

        if(snapshotView.isKind(of: WKWebView.self)){
            //WKWebView
            snapshotFinalView = snapshotView
            (snapshotFinalView as! WKWebView).screenSnapshotWKWebView { (snapShotImage) in
                finishBlock(snapShotImage)
            }

        }else if(snapshotView.isKind(of: UIWebView.self)){

            //UIWebView
            let webView = snapshotView as! UIWebView
            snapshotFinalView = webView.scrollView
            (snapshotFinalView as! UIScrollView).screenSnapshotScrollView { (snapShotImage) in
                finishBlock(snapShotImage)
            }
        }else if(snapshotView.isKind(of: UIScrollView.self) ||
            snapshotView.isKind(of: UITableView.self) ||
            snapshotView.isKind(of: UICollectionView.self)
            ){
            //ScrollView
            snapshotFinalView = snapshotView
            (snapshotFinalView as! UIScrollView).screenSnapshotScrollView { (snapShotImage) in
                finishBlock(snapShotImage)
            }
        }else{
            print("不支持的类型")
            snapshotFinalView.screenSnapshot { (snapShotImage) in
                finishBlock(snapShotImage)
            }
        }



    }

}

// MARK: 分享图片
extension NSObject {


    //    let image = self.screenSnapshot(save: false, view:self.collectionView!)
    //    self.xnShare(self, image: image!)


    // MARK:
    // MARK: 使用UIActivityViewController进行分享
    /// 使用UIActivityViewController进行分享
    func xnShare(_ vc: UIViewController ,image: UIImage) {

        /*
         // 得到文件URL
         let fileURL = returnURLWithFileName(fileName);

         // 可以传多张,添加到这个数组
         let urlArray = [fileURL];
         */

        // 另一种方法 得到image
        //let image = UIImage.init(named: fileName)!;

        // 可以传多张,添加到这个数组
        let urlArray = [image];


        let activityVC = UIActivityViewController.init(activityItems: urlArray, applicationActivities: nil);

        // 屏蔽那些模块
        let cludeActivitys = [

            // 保存到本地相册
            UIActivity.ActivityType.saveToCameraRoll,

            // 拷贝 复制
            UIActivity.ActivityType.copyToPasteboard,

            // 打印
            UIActivity.ActivityType.print,

            // 设置联系人图片
            UIActivity.ActivityType.assignToContact,


            // Facebook
            UIActivity.ActivityType.postToFacebook,

            // 微博
            UIActivity.ActivityType.postToWeibo,

            // 短信
            UIActivity.ActivityType.message,

            // 邮箱
            UIActivity.ActivityType.mail,

            // 腾讯微博
            UIActivity.ActivityType.postToTencentWeibo,

            UIActivity.ActivityType.postToTwitter,

            UIActivity.ActivityType.postToVimeo,

            UIActivity.ActivityType.airDrop,

            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.openInIBooks, // 9.0


        ];

        // 排除活动类型
        activityVC.excludedActivityTypes = cludeActivitys;

        // 呈现分享界面
        vc.present(activityVC, animated: true) {

            //print("开始AirDrop分享");
        };


    }

    // MARK:
    // MARK: 返回文件的URL
    /// 返回文件的URL
    fileprivate func returnURLWithFileName(_ fileName: String) -> URL {

        let arr = fileName.components(separatedBy: ".");

        let pathString = Bundle.main.path(forResource: arr.first, ofType: arr[1]);

        let fileURL = URL(fileURLWithPath: pathString!);

        return fileURL;
    }


}
