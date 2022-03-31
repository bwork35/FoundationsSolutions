//
//  ContactError.swift
//  Contacts
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation

enum ContactError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    case unableToDeleteRecord
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return "There was an error:  \(error) -- \(error.localizedDescription)"
        case .couldNotUnwrap:
            return "There was an error unwrapping contact."
        case .unableToDeleteRecord:
            return "There was an error deleting a record from CloudKit."
        }
    }
}
