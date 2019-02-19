//
//  Album.swift
//  VirtualTourist
//
//  Created by Sarah Alhumud on 14/06/1440 AH.
//  Copyright © 1440 Sarah Alhumud. All rights reserved.
//

import Foundation
import MapKit

class Album {
    /// The photos contained by the Album
    var photos: [Photo] = []
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        photos = []
    }
}

extension Album {
    /// Add a photo to the album
    func addPhoto(photo: Photo) {
        photos.append(photo)
    }
    
    var count: Int {
        return photos.count
    }
}
