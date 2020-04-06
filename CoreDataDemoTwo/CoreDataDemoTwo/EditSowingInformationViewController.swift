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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditInfo))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSeedInfo))
        
        editView.changePlantButton.addTarget(self, action: #selector(changePlant), for: .touchUpInside)
    }
    
    
    @objc func cancelEditInfo() {
        print("Returning to seedlings table without saving.")
        
        let seedDate = editView.datePicker.date
        let seedCount = Int(editView.seedNumberTextField.text ?? "0") ?? 0
        if Calendar.current.isDateInToday(seedDate) && seedCount == 0 {
            coreDataDelegate.deleteSeed(seed)
        }
        coreDataDelegate.saveContext()
        coreDataDelegate.loadSavedData()
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
    
    
    @objc func changePlant(sender: UIButton) {
        print("Tapped 'Change Plant' button.")
        if let nc = navigationController {
            if let firstVC = nc.viewControllers.first as? AllPlantsTableViewController {
                firstVC.movingSeed = seed
                nc.popToViewController(firstVC, animated: true)
            } else {
                print("Cannot get first AllPlantsTableViewController.")
            }
        } else {
            print("Cannot get navigation controller.")
        }
    }
}
