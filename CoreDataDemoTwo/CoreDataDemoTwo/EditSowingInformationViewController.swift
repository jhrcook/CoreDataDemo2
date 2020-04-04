//
//  EditSowingInformationViewController.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import Anchorage

class EditSowingInformationViewController: UIViewController {

    var seed: Seed!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit seed"
        
        let editView = EditSowingInformationView()
        editView.seed = seed
        view.addSubview(editView)
        editView.edgeAnchors == view.edgeAnchors

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
