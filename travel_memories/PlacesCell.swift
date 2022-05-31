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
//    func setplacecell(Cobject : Places)
//    {
////        PlaceName.text = Cobject.name
////        PlaceDesp.text = Cobject.description
////        PlaceImage.image = UIImage(named: Cobject.image)
//
//        placeImage.image = UIImage(named: Cobject.image)
//        placeName.text = Cobject.name
//        placeDesp.text = Cobject.description
//    }
    
    
}
