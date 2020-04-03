# Core Data Demo 2

[![jhc github](https://img.shields.io/badge/GitHub-jhrcook-181717.svg?style=flat&logo=github)](https://github.com/jhrcook)
[![jhc twitter](https://img.shields.io/badge/Twitter-@JoshDoesA-00aced.svg?style=flat&logo=twitter)](https://twitter.com/JoshDoesa)
[![jhc website](https://img.shields.io/badge/Website-Joshua_Cook-5087B2.svg?style=flat&logo=telegram)](https://joshuacook.netlify.com)  
![Swift](https://img.shields.io/badge/Swift-Swift_Project-FA7343.svg?style=flat&logo=swift)
![iOS](https://img.shields.io/badge/iOS-iOS_Project-999999.svg?style=flat&logo=apple)

This is a simple iOS application where I intend to practice setting up and using CoreData.

---

## Getting Started

As this app is intended as practice for another app I plan to develop in the future, I will be creating a CoreData model responsible for managing seedlings and information about them.
The plants will have a genus and species.
It will also have information about the sowing including the date sown and number of seeds.
(In the real application, there will be more attributes, but this will suffice for now.)
All of this information can be edited by the user.
The changing of the date of sowing and number of seeds are easy to implement, but it is more difficult to know how to react if the user changes the species of the plant when it is in a detail view or submenu.

This demonstration app will have three views:

1. The root view will be a table view of each plant species.
2. Tapping on a row will bring up all of the sowings of that species.
3. Tapping on a specific sowing will enter a single view that will show some information.

Since I have yet to learn SwiftUI, this will have to be done using UIKit.
However, I really do not like the Storyboards, and so I have decided to remove it and create and navigate the UI programmatically.
For setting the constraints, I will use the [Anchorage](https://github.com/Rightpoint/Anchorage) package from RightPoint.

I removed the Storyboard by following this tutorial: [How To Start An iOS App Without Storyboards With Screenshots](https://www.zerotoappstore.com/how-to-start-an-ios-app-without-storyboards.html)

## Setting-up CoreData

**[Apple's Guide to CoreData](https://developer.apple.com/documentation/coredata)**

### Creating the `Seedling` entity

* [Creating a Core Data Model](https://developer.apple.com/documentation/coredata/creating_a_core_data_model)
* [Modeling Data](https://developer.apple.com/documentation/coredata/modeling_data)

I created a `Seedling` entity with the following attributes:

* `genus: String`
* `species: String`
* `dateSown: Date`
* `id: UUID`
* `numberOfSeeds: Int16`

I also removed the optionals for each of these values in the "Seedling+CoreDataProperties.swift" file.
Each attribute is not "Optional" and the `numberOfSeeds` attribute has a default value of 0.
The Codegen setting of the `Seedling` entity was set to "Manual/None" and I created the two Swift files using Editor > Create NSManagedObject Subclass….


### Creating the CoreData stack

* [Setting Up a Core Data Stack](https://developer.apple.com/documentation/coredata/setting_up_a_core_data_stack)

I initialized the `NSPersistentContainer` object as a lazy variable in the SceneDelegate file.
It is then passed to the `AllPlantsTableViewController` instance created before pushing it as the view controller.
This is the `container` attribute of the `AllPlantsTableViewController` class.

I then created a `NSFetchedResultsController` object to dynamically load `Seedling` objects when needed for table.

```swift
var fetchedResultsController: NSFetchedResultsController<Seedling>!
```

This object reports the number of sections and number of rows per section in the respective methods of the `AllPlantsTableViewController`.

I also created `loadSavedData()` and `saveContext()` methods that load and save the data, respectively.
The former creates the `fetchedResultsController` if it doesn't exist, and only fetches 20 objects at a time.

To load in random data at the beginning, I created a private method `makeFakePlantData()`.

## Additional UI

I created a custom `UITableViewCell` for the `AllPlantsTableViewController`, `AllPlantsTableViewCell`.
When passed a seedling, it configures itself.

<img src="assets/Apr-02-2020_21-00-34.gif" width=300/>

---

**branch: `relationship-model`**

I have gotten the basic model working: just a data base of seedlings.
Now I want to go one step further and have two related data bases: a one-to-many relationship of plants and seedlings.

