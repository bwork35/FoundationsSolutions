//
//  Contact.swift
//  Contacts
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation
import CloudKit

struct ContactStrings {
    static let recordTypeKey = "Contact"
    fileprivate static let nameKey = "Name"
    fileprivate static let numberKey = "Number"
    fileprivate static let emailKey = "Email"
} //End of struct

class Contact {
    
    var name: String
    var number: String?
    var email: String?
    
    let recordID: CKRecord.ID
    
    init(name: String, number: String?, email: String?, recordID: CKRecord.ID = CKRecord.ID(recordName:UUID().uuidString)) {
        self.name = name
        self.number = number
        self.email = email
        self.recordID = recordID
    }
} //End of class

extension Contact {
    convenience init?(ckRecord: CKRecord) {
        
        guard let name = ckRecord[ContactStrings.nameKey] as? String else {return nil}
        let number = ckRecord[ContactStrings.numberKey] as? String
        let email = ckRecord[ContactStrings.emailKey] as? String
        
        self.init(name: name, number: number, email: email, recordID: ckRecord.recordID)
    }
} //End of extension

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactStrings.recordTypeKey, recordID: contact.recordID)
        
        self.setValuesForKeys([
            ContactStrings.nameKey : contact.name
        ])
        
        if let number = contact.number {
            self.setValue(number, forKey: ContactStrings.numberKey)
        }
        
        if let email = contact.email {
            self.setValue(email, forKey: ContactStrings.emailKey)
        }
    }
} //End of extension

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.recordID == rhs.recordID
    }
} //End of extension


