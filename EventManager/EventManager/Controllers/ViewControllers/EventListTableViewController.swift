//
//  EventListTableViewController.swift
//  EventManager
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class EventListTableViewController: UITableViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchAllEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }

        let event = EventController.shared.events[indexPath.row]
        
        cell.event = event
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.delete(eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else { return }
            let event = EventController.shared.events[indexPath.row]
            destination.event = event
        }
    }

} //End of class

extension EventListTableViewController: EventAttendingDelegate {
    func toggleEventIn(cell: EventTableViewCell) {
        guard let event = cell.event else { return }
        EventController.shared.toggleIsAttendingFor(event)
        cell.updateViews()
    }
} //End of extension
