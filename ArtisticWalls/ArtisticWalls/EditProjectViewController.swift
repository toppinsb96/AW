//
//  EditProjectViewController.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 12/4/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import os.log

class EditProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    
     /*let animals = ["Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval"]*/
    
    var project = ProjectA()
    var rooms = [RoomA]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonEmailCustomer: UIButton!
    
    @IBOutlet weak var buttonAddRoom: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var costLabel: UILabel!
    
    // name should be changed to emailProject
    @IBAction func emailCustomerPressed(_ sender: Any) {
        sendEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // attempting to maintain aesthetics for all devices
        tableView.center.y = 0.75 * CGFloat(UIScreen.main.bounds.height)
        tableView.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                      height: 0.45 * UIScreen.main.bounds.height)

        // scale adjustments get screwed up by auto layout
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath as IndexPath)
        cell.textLabel?.text = rooms[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    // e-mail functions
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("Artistic Walls Quote")
        mailComposerVC.setMessageBody("Supply cost to user and/or customer", isHTML: false)
        // FIXME: messageBody must contain all rooms and component info of project
        
        return mailComposerVC
    }

    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration settings and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
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
        
        project = ProjectA(name: name, cost: cost, rooms: rooms)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
