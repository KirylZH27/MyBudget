//
//  UIImage+Extension.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 8.07.23.
//

import UIKit
// MARK: When uploading a photo to reduce the size of the photo. For an avatar, a large photo is not needed, so as not to take up space in the storage
extension UIImage {
    
    func scale(newSize: CGSize, compressionQuality: CGFloat = 1) -> UIImage? {
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        
        let maxWidth: CGFloat = newSize.width
        let maxHeight: CGFloat = newSize.height
        
        var imgRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = maxWidth / maxHeight
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        
        guard let imageData = img.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    
    func resizeByByte(maxByte: Int) -> Data {
        var compressQuality: CGFloat = 1
        let minCompressQuality: CGFloat = 0.1
        
        var imageData = self.jpegData(compressionQuality: compressQuality)!
        var imageByte = self.jpegData(compressionQuality: 1)?.count
        
        while (imageByte! > maxByte) && compressQuality > minCompressQuality {
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageByte = self.jpegData(compressionQuality: compressQuality)?.count
            compressQuality -= 0.1
        }
        return imageData
    }
}
