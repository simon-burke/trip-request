//
//  Created by Simon Burke on 5/16/20.
//  Copyright © 2020 Simon Burke. All rights reserved.
//

import Foundation


struct FormResponse: Codable {
    var requestType: String
    var name: String
    var reason: String
    var date: String
    var returnDate: String
    var advisorEmail: String
    var teacher1: String
    var teacher2: String
    var teacher3: String
    var transportation: String
    var host: String
    var location: String
}
