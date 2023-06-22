//
//  Utils.swift
//  UIKit-Nano
//
//  Created by Gabriel Medeiros Martins on 21/06/23.
//

import Foundation
import UIKit

func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(newSize)
    image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!.withRenderingMode(.alwaysOriginal)
}
