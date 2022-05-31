//
//  PlacesCell.swift
//  travel_memories
//
//  Created by Vir Davinder Singh on 2022-05-26.
//

import UIKit

class PlacesCell: UITableViewCell {

    
//    @IBOutlet weak var PlaceImage: UIImageView!
    
//    @IBOutlet weak var PlaceName: UILabel!
    
//    @IBOutlet weak var PlaceDesp: UILabel!
    
    @IBOutlet weak var placeImage: UIImageView!
    
   
    @IBOutlet weak var placeName: UILabel!
    
    
    @IBOutlet weak var placeDesp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setplacecell(Cobject : PlacesModel)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        if let m = Cobject.media.first?.originalUrl {
            print("Path : " + m)
            if let data = FileManager.default.contents(atPath: imagesDirectoryPath.appending("/" + m)) {
                placeImage.image = UIImage(data: data)
            }
        }
        placeName.text = Cobject.name
        placeDesp.text = Cobject.shortDescription
    }
    
    
}
