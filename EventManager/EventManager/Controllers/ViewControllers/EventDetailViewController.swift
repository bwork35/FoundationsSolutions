//
//  EventDetailViewController.swift
//  EventManager
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class EventDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var createNewEventLabel: UILabel!
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDateDatePicker: UIDatePicker!
    
    //MARK: - Properties
    var event: Event?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let eventTitle = eventTitleTextField.text, !eventTitle.isEmpty else { return }
        let eventDate = eventDateDatePicker.date
        
        if let event = event {
            EventController.shared.update(event, title: eventTitle, date: eventDate)
        } else {
            EventController.shared.createEventWith(title: eventTitle, date: eventDate)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let event = event else { return }
        eventTitleTextField.text = event.title
        eventDateDatePicker.date = event.date ?? Date()
        createNewEventLabel.text = "Edit Event"
    }

} //End of class
