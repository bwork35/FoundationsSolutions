//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

class ItemListTableViewController: UITableViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistenceStore()
    }
    
    //MARK: - Actions
    @IBAction func addItemButtonTapped(_ sender: Any) {
        presentAddItemAlert()
    }
    
    //MARK: - Helper Methods
    func presentAddItemAlert() {
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "What do you need from the store?"
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "add", style: .default) { _ in
            guard let itemName = alertController.textFields?.first?.text, !itemName.isEmpty else { return }
            ItemController.shared.createItemWith(name: itemName)
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }

        let item = ItemController.shared.items[indexPath.row]
        
        cell.item = item
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

} //End of class

extension ItemListTableViewController: ItemTableViewCellDelegate {
    func buttonTappedFor(cell: ItemTableViewCell) {
        guard let item = cell.item else { return }
        ItemController.shared.toggleDidPurchaseFor(item)
        cell.updateViews()
    }
} //End of extension
