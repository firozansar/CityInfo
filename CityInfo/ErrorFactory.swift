//
//  ErrorFactory.swift
//  World Remit
//
//  Created by Mini Projects on 28/04/2015.
//  Copyright (c) 2015 Packt Pub. All rights reserved.
//

import Foundation

class ErrorFactory {
    static let Domain = "CityInfo"
    enum Code:Int {
        case WrongHttpCode = 100,
        MissingParams = 101,
        AuthDenied = 102,
        WrongInput = 103
    }
    
    class func error(code:Code) -> NSError{
        let description:String
        let reason:String
        let recovery:String
        switch code {
        case .WrongHttpCode:
            description = NSLocalizedString("Server replied wrong code (not 200, 201 or 304)", comment: "")
            reason = NSLocalizedString("Wrong server or wrong api", comment: "")
            recovery =  NSLocalizedString("Check if the server is is right one", comment: "")
        case .MissingParams:
            description = NSLocalizedString("There are some missing params", comment: "")
            reason =  NSLocalizedString("Wrong endpoint or API version", comment: "")
            recovery = NSLocalizedString("Check the url and the server version", comment: "")
        case .AuthDenied:
            description = NSLocalizedString("Authorization denied", comment: "")
            reason =  NSLocalizedString("User must accept the authorization for using its feature", comment: "")
            recovery = NSLocalizedString("Open user auth panel.", comment: "")
        case .WrongInput:
            description = NSLocalizedString("A parameter was wrong", comment: "")
            reason = NSLocalizedString("Probably a cast wasn't correct", comment: "")
            recovery = NSLocalizedString("Check the input parameters.", comment: "")
        }
        return NSError(domain: ErrorFactory.Domain, code: code.rawValue, userInfo: [
            NSLocalizedDescriptionKey: description,
            NSLocalizedFailureReasonErrorKey: reason,
            NSLocalizedRecoverySuggestionErrorKey: recovery
            ])
    }
}



