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
For setting the constraints, I will use the ![Anchorage](https://github.com/Rightpoint/Anchorage) package from RightPoint.




![Creating a Core Data Model](https://developer.apple.com/documentation/coredata/creating_a_core_data_model)


