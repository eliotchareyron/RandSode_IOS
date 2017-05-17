//
//  SerieViewController.swift
//  MovieDB
//
//  Created by etudiant on 08/02/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import SDWebImage

class SerieViewController: UIViewController,
UINavigationControllerDelegate {
    var info_serie = [Serie_ep_saison]()
    
    var serie: Serie?
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TitreLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBAction func Random(_ sender: UIButton) {
        let id_serie : String
        id_serie = serie!.id.stringValue
        Randomep(id: id_serie)
    }
    
    @IBOutlet weak var titreep: UILabel!
    
    @IBOutlet weak var descriptionep: UITextView!
    //MARK: navigation
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let serie = serie {
            TitreLabel.text = serie.titre
            descriptionTextView.text   = serie.description
            
            ImageView.sd_setImage(with: URL(string: serie.poster), placeholderImage: UIImage(named: "default.png"))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func Randomep(id : String) {
        
        let urlString = "https://api.themoviedb.org/3/tv/" + id + "?api_key=6eea0576c85e5ebf9fd8e438a8d8b316&language=en-US"
        
        let url = URL(string: urlString)
        
        self.info_serie.removeAll()
       
        var urlstring : String = ""
       
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let results: NSArray = (parsedData["seasons"] as? NSArray)!
                    
                    
                    var num_saison : NSNumber = 0.0
                    var nb_episode : NSNumber = 0.0
                    var id_ep : NSNumber = 0.0

                    
                    for dict in results as! [NSDictionary]{
                        
                        
                       id_ep = dict.value(forKey: "id") as! NSNumber
                        num_saison = dict.value(forKey: "season_number") as! NSNumber
                         nb_episode = dict.value(forKey: "episode_count") as! NSNumber
                        
                       
                        let serie_ep_saison = Serie_ep_saison(id:id_ep ,num_saison : num_saison , nb_episode : nb_episode)
                                                              
                        self.info_serie += [serie_ep_saison]
                        
                    }
                    let index = Int(arc4random_uniform(UInt32(self.info_serie.count - 1)))
                    
                    let numsaison = self.info_serie[index].num_saison
                    let epnumber : NSNumber = Int(arc4random_uniform(UInt32(self.info_serie[index].nb_episode)) + 1) as NSNumber
                 
                   urlstring = "https://api.themoviedb.org/3/tv/" + id + "/season/" + numsaison.stringValue
                    
                    urlstring +=  "/episode/" + epnumber.stringValue + "?api_key=6eea0576c85e5ebf9fd8e438a8d8b316&language=fr-FR"
                   
                    let url2 = URL(string: urlstring)
                    URLSession.shared.dataTask(with:url2!) { (data, response, error) in
                        if error != nil {
                            print(error!)
                        } else {
                            do {
                                
                                let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                                let name: NSString = (parsedData["name"] as? NSString)!
                                let overview : NSString = (parsedData["overview"] as? NSString)!
                                
                                 DispatchQueue.main.async {
                                self.titreep.text = name as String
                                self.descriptionep.text = overview as String
                                }
                                
                            } catch let error as NSError {
                                print(error)
                            }
                        }
                        
                        }.resume()
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
       
        
        
    }
    
    
    
    
    
}


