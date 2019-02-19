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
    var album: [Photo] = []
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        album = []
    }
}

extension Album {
//    /// Add a new photo to the notebook
//    func addPhoto() {
//        album.append(Photo())
//    }
//
//    /// Removes the note at a specific index
//    func removePhoto(at index: Int) {
//        album.remove(at: index)
//    }
}
