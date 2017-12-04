//
//  ProjectsTableViewController.swift
//  ArtisticWalls
//
//  Created by Brandon Toppins on 11/30/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProjectsTableViewController: UITableViewController {

    var dbRef: DatabaseReference!
    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child("project-items")
        // startObservingDB()
    }
    func viewData() {
        Auth.auth().addStateDidChangeListener { (auth: Auth, user: FirebaseAuth.User?) in
            print(user?.email)
            if user?.email != nil {
                print("Welcome")
                self.startObservingDB()
                let result = user?.email
            }else{
                print("You need to sign up or login first")
            }
        }
    }
    @IBAction func loginAndSignUp(_ sender: Any) {
        
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        userAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "email"
        }
        userAlert.addTextField { (textfield:UITextField) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = "password"
        }
        userAlert.addAction(UIAlertAction(title: "Sign in", style: .default, handler: { (action:UIAlertAction) in
            let emailTextField = userAlert.textFields!.first!
            let passwordtextField = userAlert.textFields!.last!
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordtextField.text!)
            self.viewData()
        }))
        userAlert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { (action:UIAlertAction) in
            let emailTextField = userAlert.textFields!.first!
            let passwordtextField = userAlert.textFields!.last!
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordtextField.text!, completion: nil)
        }))
        self.present(userAlert, animated: true, completion: nil)
    }
    func startObservingDB () {
        dbRef.observe(.value) { (snapshot:DataSnapshot) in
            var newProjects = [Project]()
            
            for project in snapshot.children {
                let projectObject = Project(snapshot: project as! DataSnapshot)
                newProjects.append(projectObject)
            }
            
            self.projects = newProjects
            self.tableView.reloadData()
        }
        
    }
    @IBAction func addProject(_ sender: Any) {
        let projectAlert = UIAlertController(title: "New Project", message: "Enter Project Name", preferredStyle: .alert)
            projectAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Your Project"
        }
        
        let userContent = ""
        
        projectAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            if let projectContent = projectAlert.textFields?.first?.text{
                if projectContent == "" { return }
                self.viewData()
                let project = Project(content: projectContent, addedByUser: userContent)
                let projectRef = self.dbRef.child(projectContent.lowercased())
                
                projectRef.setValue(project.toAny())
            }
        }))
        
        self.present(projectAlert, animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.content
        cell.detailTextLabel?.text = project.addedByUser
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let project = projects[indexPath.row]
            
            project.itemRef?.removeValue()
        }
    }
}
/*
@IBAction func addProject(_ sender: Any) {
    let projectAlert = UIAlertController(title: "New Project", message: "Enter Project Name", preferredStyle: .alert)
    
    projectAlert.addTextField { (textField:UITextField) in
        textField.placeholder = "Your Project"
    }
    projectAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
        if let projectContent = projectAlert.textFields?.first?.text {
            let project = Project(content: projectContent, addedByUser: "Brandon Toppins")
            let projectRef = self.dbRef.child(projectContent.lowercased())
            
            projectRef.setValue(project.toAny())
        }
    }))
    
    self.present(projectAlert, animated: true, completion: nil)
}
*/
