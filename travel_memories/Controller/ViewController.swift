//
//  ViewController.swift
//  travel_memories
//
//  Created by Swapnil Kumbhar on 2022-05-17.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
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
       // self.present(nextViewController, animated:true, completion:nil)
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
    
//    func filldata()
//    {
//        places.append(Places(description: "The Taj Mahal (Jan 2022 - Mar 2022) is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal .", name: "Taj Mahal ", image: "Tajmahal_1"))
//        places.append(Places(description: "Austria, officially the Republic of Austria, is a country in the southern part of Central Europe.", name: "Austria ", image: "austria_1"))
//        places.append(Places(description: "Also known as the Latin Quarter, the 5th arrondissement is home to the Sorbonne university and student-filled cafes. It's also known for its bookshops, including the famed Shakespeare & Company.", name: "Paris ", image: "paris"))
//
//
//    }
//    var places : [Places] = []
//    var filteredData : [Places] = []
    
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
                }


        else
        {
            for i in 0..<places.count {
                    if places[i].name.lowercased().contains(searchText.lowercased())
                    {
                        filteredData.append(places[i])
                    }
                }
        }
                self.tableview.reloadData()
    }
        
    @IBAction func addJournal(_ sender: UIButton) {
        
        
        //let storyBoard : UIStoryboard = UIStoryboard(name: view.self, bundle:nil)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddForm") as! AddFormViewController
        //self.present(nextViewController, animated:true, completion:nil)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
//    var placeModel_1 = PlacesModel(id: "", name: "Taj Mahal", shortDescription:"The Taj Mahal (Jan 2022 - Mar 2022) is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal ." , latitude: 78.23, longitude: -32, media: [])
//    var placeModel_2 = PlacesModel(id: "", name: "Paris", shortDescription:"Also known as the Latin Quarter, the 5th arrondissement is home to the Sorbonne university and student-filled cafes. It's also known for its bookshops, including the famed Shakespeare & Company." , latitude: 18.23, longitude: -72, media: [])
//    var placeModel_3 = PlacesModel(id: "", name: "Austria", shortDescription:"Austria, officially the Republic of Austria, is a country in the southern part of Central Europe. ." , latitude: 68.23, longitude: -52, media: [])

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = JournalDataManager.shared.getAllSavedPlaces()
//        JournalDataManager.shared.saveNewPlace(place: placeModel_1)
//        JournalDataManager.shared.saveNewPlace(place: placeModel_2)
//        JournalDataManager.shared.saveNewPlace(place: placeModel_3)
        print("PLACES -------->>>>> " , places[0].name)
        print("PLACES -------->>>>> " , places[1].name)
        print("PLACES -------->>>>> " , places[2].name)
        
        tableview.delegate = self
        tableview.dataSource = self
      
        searchBar.delegate = self
        filteredData = places
        
        
        
        
        
    }

}
