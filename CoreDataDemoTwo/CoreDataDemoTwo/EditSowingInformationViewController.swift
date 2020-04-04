//
//  EditSowingInformationViewController.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import Anchorage


protocol CoreDataSaveDelegate {
    func saveContext()
    func loadSavedData()
    func deleteSeed(_ seed: Seed)
}

class EditSowingInformationViewController: UIViewController {

    var seed: Seed!
    var coreDataDelegate: CoreDataSaveDelegate!
    
    let editView = EditSowingInformationView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
        editView.seed = seed
        view.addSubview(editView)
        editView.edgeAnchors == view.edgeAnchors
        editView.setupSubViews()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit seed"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancerEditInfo))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSeedInfo))
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(seedNumberTapped))
//        editView.seedNumberTextField.isUserInteractionEnabled = true
//        editView.seedNumberLabel.addGestureRecognizer(tap)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func cancerEditInfo() {
        print("Returning to seedlings table without saving.")
        coreDataDelegate.deleteSeed(seed)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveSeedInfo() {
        print("Saving information and returning to seedlings table.")
        
        seed.dateSown = editView.datePicker.date
        let newSeedCount = editView.seedNumberTextField.text ?? ""
        seed.seedCount = Int16(newSeedCount) ?? 0
        
        coreDataDelegate.saveContext()
        coreDataDelegate.loadSavedData()
        
        navigationController?.popViewController(animated: true)
    }

}
