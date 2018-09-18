//
//  Gradients.swift
//  Tomatoro
//
//  Created by Vanna Phong on 16/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hexCode: String) {
        
        var hex = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        if hex.count != 6 {
            return nil
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hex).scanHexInt32(&rgb)
        
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF0000) / 255.0,
            green: CGFloat((rgb >> 8) & 0x00FF00) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
