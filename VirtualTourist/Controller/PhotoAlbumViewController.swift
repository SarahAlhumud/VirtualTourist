//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Sarah Alhumud on 11/06/1440 AH.
//  Copyright © 1440 Sarah Alhumud. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionBtn: UIButton!
    
    var coordinate: CLLocationCoordinate2D!
    var photos: [Photo]!
    var pin: Pin!
    var dataController: DataController!
    
    @IBAction func newCollectionBtnPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let predicate = NSPredicate(format: "pin == %@", pin)
        // fetch request
        let fetchRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = predicate
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            photos = result
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        setUIEnabled(false)
        
        if photos.isEmpty {
            
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
                    
                    guard let imageData = try? Data(contentsOf: imageURL!) else {
                        print("Image does not exist at \(String(describing: imageURL))")
                        return
                    }
                    
                    // TODO
                    let photo: Photo = Photo(context: self.dataController.viewContext)
                    photo.uri = imageURL
                    photo.rawPhoto = imageData
                    photo.pin = self.pin
                    try? self.dataController.viewContext.save()
                    self.photos.append(photo)
                    
                    performUIUpdatesOnMain {
                        self.collectionView.reloadData()
                    }
                    
                    
                    
                }
                print("End")
                performUIUpdatesOnMain {
                    self.collectionView.reloadData()
                }
                
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
