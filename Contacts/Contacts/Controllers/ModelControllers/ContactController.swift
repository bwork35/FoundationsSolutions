//
//  ContactController.swift
//  Contacts
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation
import CloudKit

class ContactController {
    
    //MARK: - Properties
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK: - CRUD Methods
    func sortContacts() {
        self.contacts.sort(by: { $0.name.lowercased() < $1.name.lowercased() })
    }
    
    //Create
    func createContact(name: String, number: String?, email: String?, completion: @escaping (Result<String, ContactError>) -> Void) {
        
        let newContact = Contact(name: name, number: number, email: email)
        let newContactRecord = CKRecord(contact: newContact)
        
        privateDB.save(newContactRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                let savedContact = Contact(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            
            self.contacts.append(savedContact)
            self.sortContacts()
            completion(.success("Successfully saved Contact"))
        }
    }
    
    //Read(Fetch)
    func fetchAllContacts(completion: @escaping (Result<String, ContactError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactStrings.recordTypeKey, predicate: predicate)
        var operation = CKQueryOperation(query: query)
        
        var fetchedContacts: [Contact] = []
        
        operation.recordMatchedBlock = { (_, result) in
            switch result {
            case .success(let record):
                guard let fetchedContact = Contact(ckRecord: record) else { return completion(.failure(.couldNotUnwrap)) }
                fetchedContacts.append(fetchedContact)
                
            case .failure(let error):
                return completion(.failure(.ckError(error)))
            }
        }
        
        operation.queryResultBlock = { result in
            switch result {
            case .success(let cursor):
                if let cursor = cursor {
                    let nextOperation = CKQueryOperation(cursor: cursor)
                    nextOperation.queryResultBlock = operation.queryResultBlock
                    nextOperation.resultsLimit = operation.resultsLimit
                    nextOperation.recordMatchedBlock = operation.recordMatchedBlock
                    operation = nextOperation
                    self.privateDB.add(nextOperation)
                } else {
                    self.contacts = fetchedContacts
                    self.sortContacts()
                    completion(.success("Successfully fetched all Contacts."))
                }
            case .failure(let error):
                return completion(.failure(.ckError(error)))
            }
        }
        
        privateDB.add(operation)
    }
    
    //Update
    func updateContact(contact: Contact, name: String, number: String?, email: String?, completion: @escaping (Result<String, ContactError>) -> Void) {
        contact.name = name
        contact.number = number
        contact.email = email
        
        let record = CKRecord(contact: contact)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success():
                return completion(.success("Successfully updated Contact."))
            case .failure(let error):
                return completion(.failure(.ckError(error)))
            }
        }
        
        privateDB.add(operation)
    }
    
    //Delete
    func deleteContact(contact: Contact, completion: @escaping (Result<String, ContactError>) -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [contact.recordID])
        operation.qualityOfService = .userInteractive
       
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success():
                return completion(.success("Successfully deleted Contact."))
            case .failure(let error):
                return completion(.failure(.ckError(error)))
            }
        }
        
        privateDB.add(operation)
    }
    
} //End of class
