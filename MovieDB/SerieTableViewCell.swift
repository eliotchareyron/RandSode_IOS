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
    
    var serie_id : NSNumber = 0
    var description_serie: String = ""
    var image_serie: String = ""
    var poster: String = ""
    
    var favoris = [Favoris_serie]()
    
    @IBOutlet weak var titrelabel: UILabel!
    @IBOutlet weak var yearslabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var votelabel: UILabel!
    @IBOutlet weak var FavButton: UIButton!
    @IBAction func Favorie(_ sender: UIButton) {
        
        
        
        // basic usage
        
        if self.FavButton.currentImage == UIImage(named: "filed star.png") {
            self.FavButton.setImage(UIImage(named: "empty star.png"), for: .normal)
            
        } else {
            makeToast("Favoris ajouté", duration: 3.0, position: .bottom)
            self.FavButton.setImage(UIImage(named: "filed star.png"), for: .normal)
            
          
            let vote = self.votelabel.text
            let n = NumberFormatter()
            n.numberStyle = NumberFormatter.Style.decimal
            n.maximumFractionDigits = 2
            n.minimumFractionDigits = 2
            let nbvote =  n.number(from: vote!)
            
                        addfav(idserie: serie_id,titre: self.titrelabel.text!, years: self.yearslabel.text!, image: image_serie,poster: poster,description : description_serie,vote : nbvote!)
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
    
    
    public func addfav(idserie: NSNumber, titre : String,years: String, image: String,poster: String, description: String,vote: NSNumber ) {
        
        let serie_fav = Favoris_serie(id: idserie, titre: titre, years: years, image: image, description: description, vote: vote, poster: poster)
        self.favoris += [serie_fav]
        
    }
    
}
