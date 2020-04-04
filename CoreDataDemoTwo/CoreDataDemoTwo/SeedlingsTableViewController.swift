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
    
    var seedFetchedResultsController: NSFetchedResultsController<Seed>!
    
    var plant: Plant! {
        didSet {
            title = "\(plant.genus) \(plant.species)"
        }
    }
    
    private let cellID = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newSowing))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        loadSavedData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let seed = seedFetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(seed.seedCount) seeds on \(seed.dateSown.description)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return seedFetchedResultsController.sections?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seedFetchedResultsController.sections![section].numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seed = seedFetchedResultsController.object(at: indexPath)
        pushEditViewController(withSeed: seed)
    }
    
    func pushEditViewController(withSeed seed: Seed) {
        let editVC = EditSowingInformationViewController()
        editVC.seed = seed
        editVC.coreDataDelegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }

    

}


extension SeedlingsTableViewController {
    func loadSavedData() {
        if seedFetchedResultsController == nil {
            let request = Seed.createFetchRequest()
            let sort = NSSortDescriptor(key: "dateSown", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            request.predicate = NSPredicate(format: "plant.genus == %@ AND plant.species == %@", plant.genus, plant.species)
            
            seedFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            seedFetchedResultsController.delegate = self
        }
        
        do {
            try seedFetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Failed fetch of seedlings for \(plant.genus) \(plant.species)")
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func deleteSeed(_ seed: Seed) {
        // TODO
        // Delete the seed, save, and loadSavedData
        container.viewContext.delete(seed)
        saveContext()
        loadSavedData()
    }
}



extension SeedlingsTableViewController: CoreDataSaveDelegate {
    @objc func newSowing() {
        // Make a new seed with the same plant and push EditSowingInformationViewController.
        
        let newSeed = Seed(context: container.viewContext)
        newSeed.dateSown = Date()
        newSeed.seedCount = 0
        newSeed.plant = plant
        pushEditViewController(withSeed: newSeed)
        
    }
}
