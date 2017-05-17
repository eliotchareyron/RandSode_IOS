//
//  SerieTableViewCell.swift
//  MovieDB
//
//  Created by etudiant on 08/02/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class SerieTableViewCell: UITableViewCell {
    //MARK: Properties 
    
    @IBOutlet weak var titrelabel: UILabel!
    @IBOutlet weak var yearslabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var votelabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
