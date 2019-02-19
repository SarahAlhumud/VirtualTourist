//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Sarah Alhumud on 11/06/1440 AH.
//  Copyright © 1440 Sarah Alhumud. All rights reserved.
//

import UIKit
import MapKit

class PhotoAlbumViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionBtn: UIButton!
    
    var coordinate: CLLocationCoordinate2D!
    var album: Album!
    
    @IBAction func newCollectionBtnPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        setUIEnabled(false)
        album = Album(coordinate: coordinate)
        
        let _ = FlickrAPI.sharedInstance().displayImageFromFlickrBySearch(coordinate) { (photosArray, error) in
            if let error = error {
                let controller = UIAlertController(title: "", message: "\(error.localizedDescription)", preferredStyle: .alert)
                
                controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(controller, animated: true, completion: nil)
            }
            for img in photosArray {
                guard let imageUrlString = img[Constants.FlickrResponseKeys.MediumURL] as? String else {
                    print("Cannot find key '\(Constants.FlickrResponseKeys.MediumURL)' in \(img)")
                    return
                }

                // if an image exists at the url, set the image
                let imageURL = URL(string: imageUrlString)
                let photo: Photo = Photo(url: imageURL!)
                self.album.addPhoto(photo: photo)
                performUIUpdatesOnMain {
                    self.collectionView.reloadData()
                }
                
//                if let imageData = try? Data(contentsOf: imageURL!) {
//                    self.photos.append(UIImage(data: imageData)!)
//                    performUIUpdatesOnMain {
//                        self.collectionView.reloadData()
//                    }
//                } else {
//                    print("Image does not exist at \(String(describing: imageURL))")
//                }
                
            }
            print("End")
            performUIUpdatesOnMain {
                self.collectionView.reloadData()
            }
            
        }
        
        
        
    }
    
    // MARK: Helper for Creating a URL from Parameters
    
    private func flickrURLFromParameters(_ parameters: [String:AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func setUIEnabled(_ enabled: Bool) {
        
        newCollectionBtn.isEnabled = enabled
        
        // adjust newCollectionBtn alphas
        if enabled {
            newCollectionBtn.alpha = 1.0
        } else {
            newCollectionBtn.alpha = 0.5
        }
    }
    
}
