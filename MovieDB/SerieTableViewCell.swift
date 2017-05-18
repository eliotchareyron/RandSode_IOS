//
//  SerieTableViewCell.swift
//  MovieDB
//
//  Created by etudiant on 08/02/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import Toast_Swift


class SerieTableViewCell: UITableViewCell {
    //MARK: Properties
    
     var serie_id : Int = 0
    
    var serie = [Serie]()
    
    @IBOutlet weak var titrelabel: UILabel!
    @IBOutlet weak var yearslabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var votelabel: UILabel!
    @IBOutlet weak var FavButton: UIButton!
    @IBAction func Favorie(_ sender: UIButton) {
      
 
            
            // basic usage
            self.view.makeToast("This is a piece of toast")
        if self.FavButton.currentImage == UIImage(named: "filed star.png") {
            self.FavButton.setImage(UIImage(named: "empty star.png"), for: .normal)
            
        } else {
            self.FavButton.setImage(UIImage(named: "filed star.png"), for: .normal)
            
            
        }
        
        
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func addfav(id: Int) {
        
    }
    }
