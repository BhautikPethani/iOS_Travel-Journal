//
//  PlacesTableViewCell.swift
//  travel_memories
//
//  Created by Vir Davinder Singh on 2022-05-26.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setplacescell(Cobject : Places)
    {
        CountryName.text = Cobject.name
        CountryISCode.text = Cobject.description
        CountryImage.image = UIImage(named: Cobject.image)
       
    }
}
