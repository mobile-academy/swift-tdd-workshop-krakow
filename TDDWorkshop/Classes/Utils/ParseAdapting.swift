//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

protocol ParseAdapting {
    func executeQuery(query: PFQuery, completion: ([PFObject]?, ErrorType?) -> ())
    func uploadObject(object: PFObject, completion:(Bool, ErrorType?) -> ())
}

class DefaultParseAdapter: ParseAdapting {

    func executeQuery(query: PFQuery, completion: ([PFObject]?, ErrorType?) -> ()) {
        query.findObjectsInBackgroundWithBlock(completion)
    }

    func uploadObject(object: PFObject, completion:(Bool, ErrorType?) -> ()) {
        object.saveInBackgroundWithBlock(completion)
    }

}
