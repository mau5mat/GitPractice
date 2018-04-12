//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Matt Roberts on 11/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
  
  // MARK: Properties
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
}
