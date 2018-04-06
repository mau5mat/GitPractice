//
//  ViewController.swift
//  FoodTracker
//
//  Created by Matt Roberts on 03/04/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var mealNameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Handle the text field’s user input through delegate callbacks.
      nameTextField.delegate = self
    }
  
  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = textField.text
  }
  
  //MARK: UIImagePickerControlDelegate
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
  
  //MARK: Actions
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
  
  @IBAction func setDefaultLabelText(_ sender: UIButton) {
    mealNameLabel.text = "Default Text"
  }
  
}

