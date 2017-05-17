//
//  SerieTableViewController.swift
//  MovieDB
//
//  Created by etudiant on 08/02/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import SDWebImage

class SerieTableViewController: UITableViewController {
    var serie = [Serie]()
     let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discover()
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serie.count
    }

   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SerieTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? SerieTableViewCell else {
                fatalError("no cell")
        }
        
        let Serie = serie[indexPath.row]

        cell.titrelabel.text = Serie.titre
        cell.yearslabel.text = Serie.years
        cell.votelabel.text = Serie.vote.stringValue
        cell.imageview.sd_setImage(with: URL(string: Serie.image), placeholderImage: UIImage(named: "default.png"))

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let serieDetailViewController = segue.destination as? SerieViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? SerieTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let serie_liste: Serie
           
                serie_liste = serie[indexPath.row]
                serieDetailViewController.serie = serie_liste

            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

    
    
    
    
    //MARK: Private Methods
    public func discover() {
        
        self.serie.removeAll()
        let urlString = "https://api.themoviedb.org/3/discover/tv?api_key=6eea0576c85e5ebf9fd8e438a8d8b316&language=fr-FR&sort_by=popularity.desc&page=1&timezone=America/New_York&include_null_first_air_dates=false"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let results: NSArray = (parsedData["results"] as? NSArray)!
                  
                    var  name : String = ""
                    var  description : String = ""
                    var  date : String = ""
                    var id : NSNumber = 0
                    var vote : NSNumber = 0
                    var image : String
                    var poster : String
                    let image_path : String = "https://image.tmdb.org/t/p/w500"
                    
                    // Cast "dict" en NSDICTIONNARY
                    for dict in results as! [NSDictionary]{
                        
                        name = dict.value(forKey: "name")! as! String
                        description = dict.value(forKey: "overview")! as! String
                        date = dict.value(forKey: "first_air_date")! as! String
                        id = dict.value(forKey: "id")! as! NSNumber
                        vote = dict.value(forKey: "vote_average")! as! NSNumber
                        if 	dict.value(forKey: "backdrop_path") == nil  {
                            
                            image = ""
                            
                            
                        } else {
                             image = image_path + (dict.value(forKey: "backdrop_path") as! String)
                        }
                        
                        
                       
                        poster = image_path + (dict.value(forKey: "backdrop_path") as! String)

                        let serie1 = Serie(id: id, titre: name, years: date , image: image , description: description, vote: vote, poster: poster)
                        self.serie += [serie1]
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    //print(name)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        
        }
    
    public func Search(Name : String) {
        print(serie)
        self.serie.removeAll()
        print(serie)
        
        
        let urlstring  = "https://api.themoviedb.org/3/search/tv?api_key=6eea0576c85e5ebf9fd8e438a8d8b316&language=fr-FR&query=" + Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&page=1"
        
        
        print(urlstring)
        
        let url = URL(string: urlstring)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let results: NSArray = (parsedData["results"] as? NSArray)!
                    var  name : String = ""
                    var  description : String = ""
                    var  date : String = ""
                    var id : NSNumber = 0
                    var vote : NSNumber = 0
                    var image : String
                    var poster : String
                    let image_path : String = "https://image.tmdb.org/t/p/w500"
                    
                    
                    // Cast "dict" en NSDICTIONNARY
                    for dict in results as! [NSDictionary]{
                        
                        name = dict.value(forKey: "name")! as! String
                        description = dict.value(forKey: "overview")! as! String
                        date = dict.value(forKey: "first_air_date")! as! String
                        id = dict.value(forKey: "id")! as! NSNumber
                        vote = dict.value(forKey: "vote_average")! as! NSNumber
                        if 	dict.value(forKey: "backdrop_path") as? String == nil  {
                            
                            image = ""
                            
                            
                        } else {
                            image = image_path + (dict.value(forKey: "backdrop_path") as! String)
                        }
                        
                        if 	dict.value(forKey: "backdrop_path") as? String == nil  {
                            
                            poster = ""
                            
                            
                        } else {
                            poster = image_path + (dict.value(forKey: "backdrop_path") as! String)
                        }
                        
                        
                        
                        let serie1 = Serie(id: id, titre: name, years: date , image: image , description: description, vote: vote, poster: poster)
                        self.serie += [serie1]
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                        }
                        
                        
                    }
                    
                
                    
                    //print(name)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        
    }
    
    
}
extension SerieTableViewController : UISearchBarDelegate {
    @available(iOS 8.0, *)
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Search(Name: searchController.searchBar.text!)
    }
}

