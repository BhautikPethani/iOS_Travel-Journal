//
//  ViewMoreControllerViewController.swift
//  travel_memories
//
//  Created by Bhautik Pethani on 2022-05-18.
//

import MediaPlayer
import UIKit
import AVKit
import AVFoundation
import MapKit

class JournalDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.media.count - 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "PlaceImages", for: indexPath) as! SubImagesCollectionViewCell
        let data = FileManager.default.contents(atPath: imagesDirectoryPath!.appending("/" + self.media[indexPath.row].originalUrl))
        cell.SubImage.image = UIImage(data: data!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:157, height: 145)
    }
    

    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    
    var media = [UploadedMediaModel]()
    var placeModel: PlacesModel? = nil
    var player = AVPlayer();
    var playerViewController = AVPlayerViewController();
    var imagesDirectoryPath: String?
    
    var locationMnager = CLLocationManager()
    var destination: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.isZoomEnabled = true;
        map.showsUserLocation = true;
        map.delegate = self
        
        imagesCollectionView.delegate = self;
        imagesCollectionView.dataSource = self;
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath!)
        if isExist == false{
          do{
              try FileManager.default.createDirectory(at: URL(fileURLWithPath: imagesDirectoryPath!), withIntermediateDirectories: true)
            }catch{
              print("Something went wrong while creating a new folder")
            }
        }
        
        setElements()
    }
    
    func setElements(){
   
        if let url = URL(string: placeModel!.videoURL!) {
            DispatchQueue.global().async {
                let asset = AVAsset(url: url)
             let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
             assetImgGenerate.appliesPreferredTrackTransform = true
                let time = CMTimeMake(value: 1, timescale: 2)
             let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
             if img != nil {
                            let frameImg  = UIImage(cgImage: img!)
                            DispatchQueue.main.async(execute: {
                            // assign your image to UIImageView
                                
                                self.videoThumbnail.image = frameImg
                                self.videoThumbnail.contentMode = .scaleAspectFill
                            })
                    }
            }
        }
        
        placeName.text = placeModel!.name
        placeDescription.text = placeModel!.shortDescription
        
        displayLocation(latitude: placeModel!.latitude, longitude: placeModel!.longitude, title: "Place", subtitle: "Visited Place")
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
//        let selectedVideo = "v1";
//
//        let videoPath = Bundle.main.path(forResource: selectedVideo, ofType: "mp4");
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        if let videoPath = placeModel!.media.last?.originalUrl {
            let data = imagesDirectoryPath.appending("/" + videoPath)
//          print("Data : " + imagesDirectoryPath.appending("/" + videoPath))
            let videoPathURL = URL(fileURLWithPath: data);
            player = AVPlayer(url: videoPathURL);
            playerViewController.player = player;

            self.present(playerViewController, animated: true, completion: {
                self.playerViewController.player?.play();
            });
        }
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
    
}
