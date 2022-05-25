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
        cell.SubImage.image=UIImage(named: subImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:155, height: 145)
    }
    

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var subImages = ["Tajmahal_1","Tajmahal_2","Tajmahal_3"];
    
    var player = AVPlayer();
    var playerViewController = AVPlayerViewController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.delegate = self;
        imagesCollectionView.dataSource = self;
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
