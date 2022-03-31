//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Bryan Workman on 3/29/22.
//

import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func buttonTappedFor(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var didPurchaseButton: UIButton!
    
    //MARK: - Properties
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: ItemTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func didPurchaseButtonTapped(_ sender: Any) {
        delegate?.buttonTappedFor(cell: self)
    }
        
    //MARK: - Helper Methods
    func updateViews() {
        guard let item = item else { return }
        itemNameLabel.text = item.name
        
        if item.didPurchase {
            didPurchaseButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            didPurchaseButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }

} //End of class
