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

class EditProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    //emailProject
    @IBOutlet weak var buttonEmailCustomer: UIButton!
    
    @IBOutlet weak var buttonAddRoom: UIButton!
    
    
    // name should be changed to emailProject
    @IBAction func emailCustomerPressed(_ sender: Any) {
        sendEmail()
    }
    
    @IBAction func addRoomPressed(_ sender: Any) {
        
    }
    
    let animals = ["Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval", "Cat", "Dog", "Cow", "Mulval"]

    let bossEmail = "contact@withourhandspandi.com"
    
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
        cell.textLabel?.text = animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    // e-mail functions
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([bossEmail])
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
