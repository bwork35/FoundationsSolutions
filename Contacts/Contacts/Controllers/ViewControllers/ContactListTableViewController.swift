//
//  ContactListTableViewController.swift
//  Contacts
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Helper Methods
    func fetchPosts() {
        ContactController.shared.fetchAllContacts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("There was an error fetching contacts -- \(error) --\(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = contact.name
        config.secondaryText = contact.number
        cell.contentConfiguration = config
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToDelete = ContactController.shared.contacts[indexPath.row]
            guard let index = ContactController.shared.contacts.firstIndex(of: contactToDelete) else {return}
            
            ContactController.shared.deleteContact(contact: contactToDelete) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        ContactController.shared.contacts.remove(at: index)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                        
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? ContactDetailViewController else {return}
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC.contact = contact
        }
    }
    
} //End of class
