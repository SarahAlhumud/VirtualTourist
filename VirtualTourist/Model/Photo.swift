//
//  Photo.swift
//  VirtualTourist
//
//  Created by Sarah Alhumud on 14/06/1440 AH.
//  Copyright © 1440 Sarah Alhumud. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    /// The url of photo
    let url: URL
    
    /// The binary date of photo
    var rawPhoto: Data
    var img: UIImage
    
    init(url: URL) {
        self.url = url
        if let data = try? Data(contentsOf: url) {
            rawPhoto = data
        } else {
            print("Image does not exist at \(String(describing: url))")
            rawPhoto = Data()
        }
        if let imgWrap = UIImage(data: rawPhoto) {
            img = imgWrap
        } else {
            print("Image does not exist at \(String(describing: url))")
            img = UIImage()
            
        }
    }
}
