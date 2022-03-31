//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class ContactDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactPhoneNumberTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    
    //MARK: - Properties
    var contact: Contact?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = contactNameTextField.text, !name.isEmpty else {return}
        guard let number = contactPhoneNumberTextField.text,
              let email = contactEmailTextField.text else {return}
        
        if let contact = contact {
            ContactController.shared.updateContact(contact: contact, name: name, number: number, email: email) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("There was an error updating the contact -- \(error) -- \(error.localizedDescription)")
                    }
                }
            }
        } else {
            ContactController.shared.createContact(name: name, number: number, email: email) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("There was an error creating the contact -- \(error) -- \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let contact = contact else { return }
        contactNameTextField.text = contact.name
        contactPhoneNumberTextField.text = contact.number
        contactEmailTextField.text = contact.email
    }

} //End of class
