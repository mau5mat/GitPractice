//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Matt Roberts on 11/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
  
  // MARK: Properties
  var meals = [Meal]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // Use the edit button utem provided by the table view controller.
    navigationItem.leftBarButtonItem = editButtonItem
  
    
    loadSampleMeals()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // Returns the number of Meal objects in the meals array
    return meals.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "MealTableViewCell"
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
      fatalError("The dequeued cell is not an instance of MealTableViewCell")
    }
    
    // Fetches the appropiate meal for the data source layout.
    let meal = meals[indexPath.row]
    
    cell.nameLabel.text = meal.name
    cell.photoImageView.image = meal.photo
    cell.ratingControl.rating = meal.rating
    
    return cell
  }
  
  
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      meals.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    super.prepare(for: segue, sender: sender)
    
    switch(segue.identifier ?? "") {
      
    case "AddItem":
      os_log("Adding a new meal.", log: OSLog.default, type: .debug)
      
    case "ShowDetail":
      guard let mealDetailViewController = segue.destination as? MealViewController
        else {
          fatalError("Unexpected destination: \(segue.destination)")
      }
      
      guard let selectMealCell = sender as? MealTableViewCell else {
        fatalError("Unexpected sender: \(sender)")
      }
      
      guard let indexPath = tableView.indexPath(for: selectMealCell)
        else {
          fatalError("The selected cell is not being displayed by the table")
      }
      
      let selectedMeal = meals[indexPath.row]
      mealDetailViewController.meal = selectedMeal
      
    default:
      fatalError("Unexpected Segue Identifier; \(segue.identifier)")
      
    }
    
  }
  
  
  // MARK: Actions
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    
    if let sourceviewViewController = sender.source as?
      MealViewController, let meal = sourceviewViewController.meal {
      
      if let selectedIndexPAth = tableView.indexPathForSelectedRow {
        // Update and existing meal.
        meals[selectedIndexPAth.row] = meal
        tableView.reloadRows(at: [selectedIndexPAth], with: .none)
      }
      else {
        
        // Add a new meal.
        let newIndexPath = IndexPath(row: meals.count, section: 0)
        
        meals.append(meal)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    }
  }
  
  // MARK: Private Functions
  private func loadSampleMeals() {
    
    let photo1 = UIImage(named: "bibimbap")
    let photo2 = UIImage(named: "bakedPotato")
    let photo3 = UIImage(named: "bananaPizza")
    
    guard let meal1 = Meal(name: "Bibimbap", photo: photo1, rating: 4) else {
      fatalError("Unable to instantiate meal1")
    }
    
    guard let meal2 = Meal(name: "Traditional Irish Meal", photo: photo2, rating: 5) else {
      fatalError("Unable to instantiate meal2")
    }
    
    guard let meal3 = Meal(name: "Unholy Abomination", photo: photo3, rating: 3) else {
      fatalError("Unable to instantiate meal2")
    }
    
    meals += [meal1, meal2, meal3]
  }
}


