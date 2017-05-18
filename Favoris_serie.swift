//
//  Favoris_serie.swift
//
//
//  Created by etudiant on 18/05/2017.
//
//

import Foundation
//MARK: Properties

class Favoris_serie {
    var id: NSNumber = 0
    var titre: String = ""
    var years: String = ""
    var image: String
    var poster: String
    var description: String = " "
    var vote: NSNumber = 0
    
    //MARK Initialization
    
    init(id:NSNumber, titre:String, years:String, image:String, description: String, vote: NSNumber, poster: String) {
        // initialize stored properties
        self.id = id
        self.titre = titre
        self.years = years
        self.image = image
        self.poster = poster
        self.description = description
        self.vote = vote
        
    }
    
    
}
