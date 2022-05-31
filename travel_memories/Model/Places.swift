//
//  PlacesTableViewCell.swift
//  travel_memories
//
//  Created by Vir Davinder Singh on 2022-05-26.
//

import Foundation

class Places{
    
    
    var description : String
    var name: String
    var image : String
    
    
    init(description : String , name : String , image : String)
    {
        self.name = name
        self.description = description
        self.image = image
    }
  
}
