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
  
  // Creating an array of buttons, starting at 0 to be incremented to 5 in setupButtons()
  private var ratingButtons = [UIButton]()
  var rating = 0
  
  // Inspectable variables that hold the size and number of the Star pictures that will
  // be shown
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
  @IBInspectable var starCount: Int = 5
  
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
    print("👀🤩👀🤩👀🤩👀")
    
  }
  
  // MARK: Private Methods
  private func setupButtons() {
    
    // Setting up 5 of the same type of button using a For-In loop buttons when initialized
    for _ in 0..<5 {
      
      let button = UIButton()
      
      button.backgroundColor = UIColor.darkGray
      
      // Add constraints
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
      button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
      
      // Set an action for the button to execute when pressed (LEARN MORE ABOUT addTarget())
      button.addTarget(self, action:
        #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      
      // Add the button to the stack
      addArrangedSubview(button)
      
      // Adds button to the ratingButtons array
      ratingButtons.append(button)
    }
  }
  
}
