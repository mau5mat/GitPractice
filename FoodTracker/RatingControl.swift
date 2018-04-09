//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Matt Roberts on 09/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
  
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
  func ratingButtonTapped(button: UIButton) {
    print("👀🤩👀🤩👀🤩👀")
    
  }
  
  // MARK: Private Methods
  private func setupButtons() {
    let button = UIButton()
    
    button.backgroundColor = UIColor.red
    
    // Add constraints
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    
    // Set an action for the button to execute when pressed (LEARN MORE ABOUT addTarget())
    button.addTarget(self, action:
      #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
    
    // Add the button to the stack
    addArrangedSubview(button)
  }
  
}
