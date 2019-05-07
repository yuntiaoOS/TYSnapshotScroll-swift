//
//  UIImage+TYSnapshotScroll.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit

extension UIImage{

    class func getImageFromImagesArray(_ imagesArr:[UIImage]) -> UIImage {
        var image:UIImage

        let imageTotalSize :CGSize = self.getImageTotalSizeFromImagesArray(imagesArr)
        UIGraphicsBeginImageContextWithOptions(imageTotalSize, false, UIScreen.main.scale)

        //拼接图片
        var imageOffset :CGFloat = 0
        for images in imagesArr {
            images.draw(at: CGPoint(x: 0.0, y: imageOffset))
            imageOffset += images.size.height
        }

        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image

    }

    class func getImageTotalSizeFromImagesArray(_ imagesArr:[UIImage]) -> CGSize {
        var totalSize:CGSize = .zero
        for image in imagesArr {
            let imageSize:CGSize = image.size
            totalSize.height += imageSize.height
            totalSize.width = max(totalSize.width, imageSize.width)
        }
        return totalSize

    }


}

