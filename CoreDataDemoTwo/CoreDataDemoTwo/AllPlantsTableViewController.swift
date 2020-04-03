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
    
    var plantFetchedResultsController: NSFetchedResultsController<Plant>!

    
    private let cellID = "plant"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Plants"
        navigationItem.largeTitleDisplayMode = .automatic
        
        loadSavedData()
        
        print("View did load")
        // Register cells
        tableView.register(AllPlantsTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AllPlantsTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        let plant = plantFetchedResultsController.object(at: indexPath)
        cell.plant = plant
        
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if plantFetchedResultsController.fetchedObjects?.count == 0 {
            makeFakePlantData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return plantFetchedResultsController.sections?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = plantFetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plant = plantFetchedResultsController.object(at: indexPath)
        pushSeedlingsViewController(forPlant: plant)
    }
    
    
    func pushSeedlingsViewController(forPlant plant: Plant) {
        let seedlingVC = SeedlingsTableViewController()
        seedlingVC.plant = plant
        navigationController?.pushViewController(seedlingVC, animated: true)
    }
    
    
    func loadSavedData() {
        if plantFetchedResultsController == nil {
            let request = Plant.createFetchRequest()
            let sort = NSSortDescriptor(key: "genus", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20

            plantFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            plantFetchedResultsController.delegate = self
        }
        
        do {
            try plantFetchedResultsController.performFetch()
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
        print("making fake plants.")
        
        let plantNames = [
            ["Frailea", "pygmaea"],
            ["Frailea", "phaeodisca"],
            ["Haworthia", "emelyae"],
            ["Lophophora", "diffusa"],
            ["Turbinicarpus", "schmiedickeanus"],
            ["Turbinicarpus", "pseudopectinatus"],
            ["Ferocactus", "macrodiscus"],
            ["Neoporteria", "napina"],
            ["Thelocactus", "hexaedrophorus"],
            ["Neoporteria", "esmeraldana"]
        ]
        
        for plantName in plantNames {
            let plant = Plant(context: container.viewContext)
            plant.uuid = UUID()
            plant.genus = plantName[0]
            plant.species = plantName[1]
        }

        saveContext()
        loadSavedData()
        tableView.reloadData()
    }

    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
