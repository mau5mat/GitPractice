//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Matt Roberts on 11/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var meals = [Meal]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // This loads the sample data as defined in the loadSampleMeals() method
    loadSampleMeals()
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
  
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: Private Methods
  
  private func loadSampleMeals() {
    
    let samplePhoto1 = UIImage(named: "bibimbap")
    let samplePhoto2 = UIImage(named: "bananaPizza")
    let samplePhoto3 = UIImage(named: "bakedPotato")
    
    guard let meal1 = Meal(name: "Bibimbap", photo: samplePhoto1, rating: 5) else {
      fatalError("Unable to instantiate meal1")
    }
    
    guard let meal2 = Meal(name: "Banana Pizza", photo: samplePhoto2, rating: 1) else {
      fatalError("Unable to instantiate meal2")
    }
    
    guard let meal3 = Meal(name: "Traditional Homecooked Irish Food", photo: samplePhoto3, rating: 4) else {
      fatalError("Unable to instantiate meal3")
    }
    
    meals += [meal1, meal2, meal3]
    
  }
}



