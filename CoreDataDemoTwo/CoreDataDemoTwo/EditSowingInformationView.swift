//
//  EditSowingInformationView.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit

class EditSowingInformationView: UIView {
    
    var seed: Seed! {
        didSet {
            print("Set editing seed as \(seed.plant.genus) \(seed.plant.species)")
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
