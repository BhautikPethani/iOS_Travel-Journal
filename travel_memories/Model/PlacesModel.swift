//
//  PlacesModel.swift
//  travel_memories
//
//  Created by Aanchal Bansal on 2022-05-31.
//

import Foundation
import SwiftyJSON

struct PlacesModel {
    var id: String
    var name: String
    var shortDescription: String
    var latitude: Double
    var longitude: Double
    var media: [UploadedMediaModel]
    var videoURL: String?
    
    init(_ json: JSON = JSON()) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        shortDescription = json["shortDescription"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        media = json["media"].arrayValue.map({UploadedMediaModel($0)})
        videoURL = json["videoURL"].stringValue
    }
    
    init(id: String,
         name: String,
         shortDescription: String,
         latitude: Double,
         longitude: Double,
         media: [UploadedMediaModel],
         videoURL: String?) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.latitude = latitude
        self.longitude = longitude
        self.media = media
        self.videoURL = videoURL
    }
    
    func getDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["name"] = name
        dict["shortDescription"] = shortDescription
        dict["latitude"] = latitude
        dict["longitude"] = longitude
        dict["media"] = media.map({$0.getDictionary()})
        dict["videoURL"] = videoURL
        return dict
    }
}
