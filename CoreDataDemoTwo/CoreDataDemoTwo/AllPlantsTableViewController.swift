//
//  ViewController.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 3/31/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//

import UIKit
import CoreData

class AllPlantsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var container: NSPersistentContainer!
    
    var fetchedResultsController: NSFetchedResultsController<Seedling>!
    
    private let cellID = "plant"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Load the data
        loadSavedData()
        
        // Register cells
        tableView.register(AllPlantsTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let numObjects = fetchedResultsController.fetchedObjects?.count ?? 0
        print("number of fetched objects: \(numObjects)")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AllPlantsTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        let seedling = fetchedResultsController.object(at: indexPath)
        cell.seedling = seedling
        print("set \(seedling.genus) for cell \(indexPath.row)")
        
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Seedling.createFetchRequest()
            let sort = NSSortDescriptor(key: "genus", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Failed fetch.")
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


}



extension AllPlantsTableViewController {
    private func makeFakePlantData() {
        print("making fake plants:")
        for _ in 0...50 {
            let seedling = Seedling(context: container.viewContext)
            seedling.id = UUID()
            seedling.genus = randomString(length: 5)
            seedling.species = randomString(length: 8)
            seedling.dateSown = Date(timeIntervalSinceNow: Double.random(in: -100...0) * 60 * 60 * 24)
            seedling.numberOfSeeds = Int16.random(in: 0...100)
        }
        
        saveContext()
        loadSavedData()
        tableView.reloadData()
    }
    
    
    private func removeAllPlantData() {
        print("Removing all plants:")
        if let seedlings = fetchedResultsController.fetchedObjects {
            for seedling in seedlings {
                container.viewContext.delete(seedling)
            }
        }
        saveContext()
        loadSavedData()
        tableView.reloadData()
    }
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}
