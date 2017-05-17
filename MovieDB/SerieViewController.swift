//
//  SerieViewController.swift
//  MovieDB
//
//  Created by etudiant on 08/02/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import SDWebImage

class SerieViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TitreLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var serie: Serie?
    
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


}

