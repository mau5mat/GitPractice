//
//  Meal.swift
//  FoodTracker
//
//  Created by Matt Roberts on 10/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class Meal {
  
  // MARK: Properties
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Initialization
  init?(name:String, photo: UIImage?, rating: Int) {
    
    // The name must not be empty, if it is the program exits
    guard !name.isEmpty else {
      return nil
    }
    
    // The rating must be between 0 - 5 inclusively, if it isn't, the program exits
    guard (rating >= 0) && (rating <= 5) else {
      return nil
    }
    
    // Initializing the stored properties
    self.name = name
    self.photo = photo
    self.rating = rating
  }
  
}
