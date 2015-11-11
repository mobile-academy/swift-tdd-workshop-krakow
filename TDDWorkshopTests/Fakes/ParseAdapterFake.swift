//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

@testable
import TDDWorkshop

class ParseAdapterFake: ParseAdapting {

    //MARK: Properties

    var capturedQuery: PFQuery?
    var capturedQueryCompletion: (([PFObject]?, ErrorType?) -> ())?

    var capturedUploadedObject: PFObject?
    var capturedUploadCompletion: ((Bool, ErrorType?) -> ())?

    //MARK: Overrides

    func executeQuery(query: PFQuery, completion: ([PFObject]?, ErrorType?) -> ()) {
        capturedQuery = query
        capturedQueryCompletion = completion
    }

    func uploadObject(object: PFObject, completion: (Bool, ErrorType?) -> ()) {
        capturedUploadedObject = object
        capturedUploadCompletion = completion
    }

}
