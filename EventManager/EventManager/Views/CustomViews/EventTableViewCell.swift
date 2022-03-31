//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

protocol EventAttendingDelegate: AnyObject {
    func toggleEventIn(cell: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var isAttendingButton: UIButton!
    
    //MARK: - Properties
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: EventAttendingDelegate?
    
    //MARK: - Actions
    @IBAction func isAttendingButtonTapped(_ sender: Any) {
        delegate?.toggleEventIn(cell: self)
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let event = event else { return }
        eventTitleLabel.text = event.title
        
        let attendingImage = event.isAttending ? UIImage(systemName: "clock.fill") : UIImage(systemName: "clock")
        isAttendingButton.setImage(attendingImage, for: .normal)
    }
    
} //End of class
