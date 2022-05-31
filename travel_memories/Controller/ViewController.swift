//
//  ViewController.swift
//  travel_memories
//
//  Created by Swapnil Kumbhar on 2022-05-17.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
    var imagesDirectoryPath: String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeObject = filteredData[indexPath.section]
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlacesCell
        cell.layer.cornerRadius=10 //set corner radius here
        
        cell.setplacecell(Cobject: placeObject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MoreView") as! MoreViewController
       
        nextViewController.placeModel = filteredData[indexPath.section]
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 5
       }
       
       // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }
    
    var places : [PlacesModel] = []
    var filteredData : [PlacesModel] = []
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText : String )
    {
        filteredData = []
        if searchText == ""
        {
            filteredData = places
        } else {
            for i in 0..<places.count {
                if places[i].name.lowercased().contains(searchText.lowercased())
                {
                    filteredData.append(places[i])
                }
            }
        }
        self.tableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        places = JournalDataManager.shared.getAllSavedPlaces()
        tableview.delegate = self
        tableview.dataSource = self
      
        searchBar.delegate = self
        filteredData = places
    }

}
