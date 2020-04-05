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

I deleted the CoreData model and the Swift files it generated.
I then commented out any relevant code and got the table view working.

## Seedling information

The initial table view just contains rows plant names.
When one is tapped, it enters the seedling table view, another table view where each row is an instance of sowing the plant type.

### Add a new seed or edit an exists one

I had added the ability to add a new seed and edit an existing one.
There is a "+" button that, when tapped,pushes a `EditSowingInformationViewController` view controller where the information for a new sowing can be added.
If an existing cell is tapped, the same VC is pushed and the info can be added.
There are some hidden bugs that would need to be dealt with if this were the final product, but for this demo, as they do not involve CoreData, will be ignored.

<img src="assets/Apr-04-2020_17-20-00.gif" width=300/>

### Setting up the inverse relationships

I needed to be able to connect the `Plant` and `Seed` objects in CoreData.
This took the two changes:

* For the `plant` relationship of the `Seed` entity, set the inverse as `seeds`. (This autmatically sets the inverse property for the `seeds` relationship for the `Plant` entity.)
* Do *not* create an `NSFetchedResultsController` for the seeds. Instead, pull the seeds from the `plant.seeds` `Set`.

<img src="assets/Apr-05-2020_09-39-16.gif" width=300/>

### Swipe-to-delete a seed

It was very easy to add swipe-to-delete for the seeds of a plant.
First, the seed was delete from the container's `viewContext`, followed with deleting the row from the `tableView`.
Then the container's context was saved and the `NSFetechedResultsController` was reloaded.

## Changing the plant of a seed

Unfortunately, it is possible that the plant may need to be changed for a seed.
I will need to be able to do this, though it is not obvious how.

### UI 

I added text fields for the genus and species of the plant in the `EditSowingInformationView`.

### Moving a seed

The process was actually quite simple, though there are definitely many ways to do this.

I decided to add a button the the seed editing view that, when tapped, would return the user back to the main view controller showing all of the plants, and let the user select the new plant to move to.
(I am not worrying about adding a new plant because the process would just be an extension of this system and not too much new CoreData work.)

#### Step 1. Configure button in `EditSowingInformationViewController`

Below is the entire function for responding to a tap of the "Change Plant" button.

```swift
@objc func changePlant(sender: UIButton) {
    print("Tapped 'Change Plant' button.")
    if let nc = navigationController {
        if let firstVC = nc.viewControllers.first as? AllPlantsTableViewController {
            firstVC.movingSeed = seed
            nc.popToViewController(firstVC, animated: true)
        }
    }
}
```

All that happens is that the root view controller of type `AllPlantsTableViewController` is accessed and its (new) `movingSeed` attribute is set to the current seed.
This view controller is then "popped" to, directly.

#### Step 2. Moving the seed

As referenced above, there is a new `movingSeed` attribute in `AllPlantsTableViewController`.
It is an optional `Seed?`, and when set, changes the title of the view controller.
If it set to a `Seed`, then the title becomes "Select new plant."

```swift
var movingSeed: Seed? {
    didSet {
        if movingSeed == nil {
            title = "Plants"
        } else {
            title = "Select new plant"
        }
    }
}
```

I then put all of the code for moving the seed into an extension.

```swift
extension AllPlantsTableViewController {
    private func moveSeedToPlant(_ newPlant: Plant) {
        guard let movingSeed = movingSeed else { return }
        
        print("Moving seed.")
        
        let oldPlant = movingSeed.plant
        oldPlant.removeFromSeeds(movingSeed)
        
        movingSeed.plant = newPlant
        
        saveContext()
        loadSavedData()
        
        self.movingSeed = nil
    }
}
```

Here are the steps followed in the `moveSeedToPlant(_ newPlant: Plant)` function above:

1. Check if there is a seed to move, else return early.
2. Get the old plant of the seed and remove the seed from its `seeds` property. (The `removeFromSeeds(Seed)` method was built by CoreData.)
3. Set the plant of the moving seed to the new plant `newPlant`.
4. Save the context and reload the data.
5. Set the `movingSeed` to `nil` so that this process is not completed again.

#### Call `moveSeedToPlant(_ newPlant: Plant)`

The last step is to call `moveSeedToPlant(_ newPlant: Plant)` in the `tableView(_, didSelectRowAt)` function.
If `movingSeed` is `nil`, nothing will happen and the selected plant's view controller will be pushed.
If `movingSeed` is not `nil`, then the seed is moved, the CoreData store is saved and reloaded, and the plant's view controller is pushed.

<img src="assets/Apr-05-2020_11-02-16.gif" width=300/>
