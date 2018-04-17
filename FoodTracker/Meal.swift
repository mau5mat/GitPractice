//
//  Meal.swift
//  FoodTracker
//
//  Created by Matt Roberts on 10/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
  
  // MARK: NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(photo, forKey: PropertyKey.photo)
    aCoder.encode(rating, forKey: PropertyKey.rating)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    // The name is required.  If we cannot decode a name string, the initializer should fail.
    guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
      else {
        os_log("Unable to decode the name for a Meal Object", log: OSLog.default, type: .default)
        return nil
    }
    
    // Because photo is an optional property of Meal, just use a conditional cast.
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
    
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
    
    // Must call the designated initializer.
    self.init(name: name, photo: photo, rating: rating)
    
  }
  
  
  // MARK: Properties
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Types
  struct  PropertyKey {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
    
  }
  
  // MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
  
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
