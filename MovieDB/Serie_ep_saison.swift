//
//  Serie_ep_saison.swift
//  MovieDB
//
//  Created by etudiant on 17/05/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class Serie_ep_saison {
    //MARK: Properties
    
  
    var num_saison : NSNumber = 0.0
    var nb_episode : NSNumber = 0.0
    var id : NSNumber = 0.0
    
    
    //MARK Initialization
    init(id:NSNumber,num_saison : NSNumber , nb_episode : NSNumber) {
        // initialize stored properties
        
        self.id = id
        self.nb_episode = nb_episode
        self.num_saison = num_saison
        
    }
    
    
    
    
}
