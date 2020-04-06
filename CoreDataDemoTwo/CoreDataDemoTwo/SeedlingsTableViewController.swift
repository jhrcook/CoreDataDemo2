//
//  SeedlingsTableViewController.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 3/31/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import CoreData


class SeedlingsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var container: NSPersistentContainer!
    var coreDataDelegate: CoreDataSaveDelegate!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    var plant: Plant! {
        didSet {
            title = "\(plant.genus) \(plant.species)"
            tableView.reloadData()
        }
    }
    
    
    private let cellID = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newSowing))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let seed = plant.seeds.allObjects[indexPath.row] as! Seed
        let date = dateFormatter.string(from: seed.dateSown)
        cell.textLabel?.text = "\(seed.seedCount) seeds on \(date)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plant.seeds.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seed = plant.seeds.allObjects[indexPath.row] as! Seed
        pushEditViewController(withSeed: seed)
    }
    
    
    func pushEditViewController(withSeed seed: Seed) {
        let editVC = EditSowingInformationViewController()
        editVC.seed = seed
        editVC.coreDataDelegate = self.coreDataDelegate
        navigationController?.pushViewController(editVC, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let seed = plant.seeds.allObjects[indexPath.row] as! Seed
            coreDataDelegate.deleteSeed(seed)
            tableView.deleteRows(at: [indexPath], with: .fade)
            coreDataDelegate.saveContext()
            coreDataDelegate.loadSavedData()
        }
    }
    
}




extension SeedlingsTableViewController {
    @objc func newSowing() {
        // Make a new seed with the same plant and push EditSowingInformationViewController.
        let newSeed = Seed(context: container.viewContext)
        plant.seeds.adding(newSeed)
        newSeed.dateSown = Date()
        newSeed.seedCount = 0
        newSeed.plant = plant
        pushEditViewController(withSeed: newSeed)
    }
}
