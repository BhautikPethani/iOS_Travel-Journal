//
//  AddFormViewController.swift
//  travel_memories
//
//  Created by Swapnil Kumbhar on 2022-05-25.
//

import UIKit
import UniformTypeIdentifiers
import MapKit

class AddFormViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var placeModel: PlacesModel? = nil
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var uploadMediaView: UIView!
    
    var locationMnager = CLLocationManager()
    var destination: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()

        map.isZoomEnabled = true;
        map.showsUserLocation = true;
        
        locationMnager.delegate = self;
        locationMnager.desiredAccuracy = kCLLocationAccuracyBest
        locationMnager.requestWhenInUseAuthorization()
        locationMnager.startUpdatingLocation()
        
        map.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.fileSelectorAction))
        uploadMediaView.addGestureRecognizer(tapGestureRecognizer)
        singleTap()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        removePin()
//        print(locations.count)
        let userLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Current Location", subtitle: "You're Here")
    }
    
    func removePin() {
        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        removePin()
        
        // add annotation
        let touchPoint = sender.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        annotation.title = "Visited Place"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
        destination = coordinate
    }
    
    func singleTap() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        singleTap.numberOfTapsRequired = 1
        map.addGestureRecognizer(singleTap)
    }
    
    func displayLocation(latitude: CLLocationDegrees,
                         longitude: CLLocationDegrees,
                         title: String,
                         subtitle: String) {
        // 2nd step - define span
        let latDelta: CLLocationDegrees = 0.05
        let lngDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        // 3rd step is to define the location
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 4th step is to define the region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // 5th step is to set the region for the map
        map.setRegion(region, animated: true)
        
        // 6th step is to define annotation
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = location
        map.addAnnotation(annotation)
    }
    
    @objc func fileSelectorAction(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state == .ended {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true)
        }
    }
    
    func saveJournal(){
        
    }

}

extension AddFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let media = info.first else { return }
        print(media.value)

        dismiss(animated: true)
    }
    
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
}

extension ViewController: MKMapViewDelegate {
    //MARK: - viewFor annotation method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        switch annotation.title {
        case "Current Location":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "You're Here")
            annotationView.markerTintColor = UIColor.blue
            return annotationView
        case "Place":
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Visited Place")
            annotationView.animatesDrop = true
            annotationView.pinTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            return annotationView
        default:
            return nil
        }
    }
}
