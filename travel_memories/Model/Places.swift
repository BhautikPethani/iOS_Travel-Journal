//
//  PlacesTableViewCell.swift
//  travel_memories
//
//  Created by Vir Davinder Singh on 2022-05-26.
//

import Foundation

class Places{
    
    
    var id: String
    var name: String
    var shortDescription: String
    var longDescription: String
    var latitude: Double
    var longitude: Double
    var address: String
    var media: [UploadedMediaModel]
    
    
    init(id: String, name: String, shortDescription: String, longDescription: String, latitude: Double, logitude: Double, address: String, media: [UploadedMediaModel])
    {
        self.name = name
        self.description = description
        self.image = image
    }
  
}
