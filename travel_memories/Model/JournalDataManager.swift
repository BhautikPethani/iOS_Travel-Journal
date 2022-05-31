//
//  JournalDataManager.swift
//
//
//  Created by Aanchal Bansal
//  Copyright © 2022. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias JSONDictionary = [String: Any]

enum ApplicationUserDefaults {
    
    enum Key: String {
        case journalData
    }
    
    static func value(forKey key: Key) -> JSON {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            return JSON.null
        }
        return JSON(value)
    }
    static func save(value: Any, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func removeValue(forKey key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func removeAllValues() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
        }
    }
}

class JournalDataManager {
    
    static let shared = JournalDataManager()
    
    private init() {
    }
    
    func getAllSavedPlaces() -> [PlacesModel] {
        return JournalModal.shared.places
    }
    
    func removeAllSavedPlaces() {
        JournalModal.shared.deleteAllRecords()
    }
    
    func saveNewPlace(place: PlacesModel) {
        
        var newPlaceToSave = place
        newPlaceToSave.id = Date().timeIntervalSince1970.description
        var savedObject = JournalModal.shared
        var savedPlaces = savedObject.places
        savedPlaces.append(newPlaceToSave)
        savedObject.places = savedPlaces
        JournalModal.shared = savedObject
    }
    
    func deletePlace(place: PlacesModel) {
        var savedObject = JournalModal.shared
        var savedPlaces = savedObject.places
        savedPlaces.removeAll(where: {$0.id == place.id})
        savedObject.places = savedPlaces
        JournalModal.shared = savedObject
    }
}

struct JournalModal {
    var places: [PlacesModel]
    static var shared = JournalModal(ApplicationUserDefaults.value(forKey: .journalData)) {
        didSet {
            shared.saveToUserDefaults()
        }
    }
    var dictValue: JSONDictionary {
        return ["places": places.map({$0.getDictionary()})]
    }
        
    func saveToUserDefaults() {
        ApplicationUserDefaults.save(value: dictValue, forKey: .journalData)
    }    
    
    init(_ json: JSON = JSON()) {
        places = json["places"].arrayValue.map({PlacesModel($0)})
    }
    
    func deleteAllRecords() {
        ApplicationUserDefaults.removeValue(forKey: .journalData)
    }
    
    
}

struct PlacesModel {
    var id: String
    var name: String
    var shortDescription: String
    var latitude: Double
    var longitude: Double
    var media: [UploadedMediaModel]
    
    init(_ json: JSON = JSON()) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        shortDescription = json["shortDescription"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        media = json["media"].arrayValue.map({UploadedMediaModel($0)})
    }
    
    init(id: String,
         name: String,
         shortDescription: String,
         latitude: Double,
         longitude: Double,
         media: [UploadedMediaModel]) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.latitude = latitude
        self.longitude = longitude
        self.media = media
    }
    
    func getDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["name"] = name
        dict["shortDescription"] = shortDescription
        dict["latitude"] = latitude
        dict["longitude"] = longitude
        dict["media"] = media.map({$0.getDictionary()})
        return dict
    }
}

struct UploadedMediaModel {
    var originalUrl: String
    var mediaType: Int // 0 -> Photo , 1 -> Video
    
    func getDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["originalUrl"] = originalUrl
        dict["mediaType"] = mediaType
        return dict
    }
    
    init(_ json: JSON = JSON()) {
        originalUrl = json["originalUrl"].stringValue
        mediaType = json["mediaType"].intValue
    }
    
    init(originalUrl: String, mediaType: Int) {
        self.originalUrl = originalUrl;
        self.mediaType = mediaType
    }
}
    
