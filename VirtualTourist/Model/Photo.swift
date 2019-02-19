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
    var rawPhoto: Data {
        if let data = try? Data(contentsOf: url) {
            return data
        } else {
            print("Image does not exist at \(String(describing: url))")
            return Data()
        }
    }
    
    var img: UIImage {
        if let img = UIImage(data: rawPhoto) {
            return img
        } else {
            print("Image does not exist at \(String(describing: url))")
            return UIImage()
        }
    }
    
    
    init(url: URL) {
        self.url = url
    }
}
