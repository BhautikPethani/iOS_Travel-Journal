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

class MoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subImages.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "PlaceImages", for: indexPath) as! SubImagesCollectionViewCell
//        let data = FileManager.default.contents(atPath: self.media[indexPath.row])
        print(imagesDirectoryPath!.appending("/" + self.media[indexPath.row]))
        let data = FileManager.default.contents(atPath: imagesDirectoryPath!.appending("/" + self.media[indexPath.row]))
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
    var subImages = [UploadedMediaModel]();
    
    var media: [UploadedMediaModel]? = nil
    var placeModel: PlacesModel? = nil
    var player = AVPlayer();
    var playerViewController = AVPlayerViewController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.delegate = self;
        imagesCollectionView.dataSource = self;
    }
    
    func setVideoView(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        if let m = placeModel!.media.first?.originalUrl {
            if let data = FileManager.default.contents(atPath: imagesDirectoryPath.appending("/" + m)) {
                videoThumbnail.image = UIImage(data: data)
            }
        }
        placeName.text = placeModel!.name
        placeDescription.text = placeModel!.shortDescription
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        let selectedVideo = "v1";
        
        let videoPath = Bundle.main.path(forResource: selectedVideo, ofType: "mp4");
        let videoPathURL = URL(fileURLWithPath: videoPath!);
        player = AVPlayer(url: videoPathURL);
        playerViewController.player = player;
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play();
        });
    }
    
}
