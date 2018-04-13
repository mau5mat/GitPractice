//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Matt Roberts on 03/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  /*
   
   This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)',
   or constructed as part of t adding a new meal
   
   */
  var meal: Meal?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Handle the text field’s user input through delegate callbacks.
    nameTextField.delegate = self
    
    updateSaveButtonState()
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disables the Save button while editing.
    saveButton.isEnabled = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  // MARK: UIImagePickerControlDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismisses the picker if the user cancels it.
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // Making sure we only use the original representation of the image from the dictionary.
    guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
      else {
        fatalError("Expected a dictionary containing the original image, but was given \(info) instead.")
    }
    
    
    // Sets photoImageView to only display the selected image.
    photoImageView.image = selectedImage
    
    // Dismisses the picker.
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Navigation
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
  }
  
  // This method lets you configure a view controller before it's presented
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    super.prepare(for: segue, sender: sender)
    
    // Configure the destination view controller only when the save button is pressed.
    guard let button = sender as? UIBarButtonItem, button === saveButton
      else {
        
        // Log an error, useful in debugging purposes
        os_log("The save button was not pressed, cancelling..", log: OSLog.default, type: .debug)
        return
    }
    
    let name = nameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    
    // Set the meal to be passed to MealTableViewController after the unwind segue
    meal = Meal(name: name, photo: photo, rating: rating)
  }
  
  // MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    // Hides the keyboard if open.
    nameTextField.resignFirstResponder()
    
    // imagePickerController is a View Controller that lets users pick images from their photo library.
    let imagePickerController = UIImagePickerController()
    
    // The code below ensures that users can only pick photos, not take them.
    imagePickerController.sourceType = .photoLibrary
    
    // This makes sure that the ViewController is notified when a user selects an image.
    imagePickerController.delegate = self
    
    // Method call on ViewController.  Basically asking ViewController to present the view controller defined
    // by the imagePickerController.  Passing true to the animated parameter will animate the presentation
    // of the image picker controller.  Passing Nil to the completion parameter ensures that no code needs
    // to be executed after the method call is over.
    present(imagePickerController, animated: true, completion: nil)
  }
  
  // MARK: Private Methods
  private func updateSaveButtonState() {
    // Disables the Save button if the text field is empty.
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}

