//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Matt Roberts on 09/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
  
  
  // MARK: Properties
  // Creating an array of buttons, starting at 0 to be incremented to 5 in setupButtons().
  private var ratingButtons = [UIButton]()
  
  // Added property observer to rating variable that tells the updateButtonSelectionStates() method that the rating variable has changed
  // from default to something else (should be 1-5).
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }
  
  // Inspectable variables that hold the size and number of the Star pictures that will
  // be shown.
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  
  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  
  // MARK: Button Action
  @objc func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.index(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    // Calculate the rating of the selected button
    let selectedRating = index + 1
    
    // If the selected star represents the current rating, reset the rating to 0.
    if selectedRating == rating {
      rating = 0
    } else {
      // Otherwise, we set the rating to the selected star
      rating = selectedRating
    }
    
  }
  
  // MARK: Private Methods
  private func setupButtons() {
    
    // Clear and add new buttons to ratingButtons() array.
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    // Creating instance of Bundle and assigning images from Assets folder to it.
    let bundle = Bundle(for: type(of: self))
    
    let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
    let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
    // Setting up 5 of the same type of button using a For-In loop buttons when initialized.
    for index in 0..<starCount {
      
      let button = UIButton()
      
      // Calling setImage() on the button object to change the images of the button based
      // on user input.
      button.setImage(emptyStar, for: .normal)
      button.setImage(filledStar, for: .selected)
      button.setImage(highlightedStar, for: .highlighted)
      button.setImage(highlightedStar, for: [.highlighted, .selected])
      
      // Add constraints to the Button object
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: starSize.width).isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.height).isActive = true
      
      // Setting the accessability label.  This bit of code calculates a label string using the buttons index then assigns it to
      // the buttons accessibilityLabel property.
      button.accessibilityLabel = "Set \(index + 1) star rating"
      
      // Set an action for the button to execute when pressed (LEARN MORE ABOUT addTarget()).
      button.addTarget(self, action:
        #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      
      // Add the button to the stack.
      addArrangedSubview(button)
      
      // Adds button to the ratingButtons array.
      ratingButtons.append(button)
    }
    
    // This call updates the buttons selection state whenever buttons are added to the control.
    updateButtonSelectionStates()
  }
  
  private func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      
      // If the index of a button is less than the rating, that button should be selected.
      button.isSelected = index < rating
      
      // Set the hint string for the currently selected star.
      let hintString: String?
      
      if rating == index + 1 {
        hintString = "Tap to reset the rating to zero."
      } else {
        hintString = nil
      }
      
      // Calculates the value string
      let valueString: String
      
      switch (rating) {
      
      case 0:
        valueString = "No rating set."
      case 1:
        valueString = "1 star set."
      default:
        valueString = "\(rating) stars set."
      }
      
      // Assigning the hint and value strings
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString
    }
  }
  
}
