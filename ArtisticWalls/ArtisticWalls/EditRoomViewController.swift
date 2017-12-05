//
//  EditRoomViewController.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 12/4/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import os.log

class EditRoomViewController: UIViewController, UITextFieldDelegate {

    var room = RoomA()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var widthTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var countTextField: UITextField!
    
    @IBOutlet weak var paintCostTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        widthTextField.delegate = self
        heightTextField.delegate = self
        countTextField.delegate = self
        paintCostTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = true
        
        if((widthTextField.text?.isnumberordouble)! && (heightTextField.text?.isnumberordouble)! &&
            (countTextField.text?.isnumberordouble)! && (paintCostTextField.text?.isnumberordouble)!) {
            room.width = CGFloat(Double(widthTextField.text!)!)
            room.height = CGFloat(Double(heightTextField.text!)!)
            let count = CGFloat(Double(countTextField.text!)!)
            let paintCost = CGFloat(Double(paintCostTextField.text!)!)
            
            
            room.cost = room.width * room.height * count * paintCost
        }


        costLabel.text = String(describing: room.cost)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = "name"
        let cost = CGFloat(Double(costLabel.text!)!)
        
        room = RoomA(name: name, cost: cost, width: 0.0, height: 0.0, components: [ComponentA]())
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension String  {
    var isnumberordouble: Bool { return Double(self.trimmingCharacters(in: .whitespaces)) != nil }
}
