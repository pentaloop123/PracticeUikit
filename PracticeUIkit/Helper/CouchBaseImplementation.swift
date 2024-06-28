////
////  CouchBaseImplementation.swift
////  PracticeUIkit
////
////  Created by ladmin on 11/06/2024.
////
//
//import Foundation
//swift
//Copy code
//import CouchbaseLiteSwift
//
//func startPullReplication(completion: @escaping (Error?) -> Void) {
//    guard let url = URL(string: self.couchbaseDBURL) else {
//        completion(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
//        return
//    }
//    
//    let targetEndpoint = URLEndpoint(url: url)
//    var pullReplicatorConfig = ReplicatorConfiguration(database: self.database, target: targetEndpoint)
//    pullReplicatorConfig.replicatorType = .pull
//    pullReplicatorConfig.continuous = false
//
//    let channels = setupChannels()
//    pullReplicatorConfig.channels = channels
//
//    let pullReplicator = Replicator(config: pullReplicatorConfig)
//    pullReplicator.addChangeListener { change in
//        if change.status.activity == .stopped {
//            completion(change.status.error)
//        }
//    }
//
//    pullReplicator.start()
//}
//
//func setupChannels() -> [String] {
//    let userID = UserDefaults.standard.string(forKey: "user_id") ?? ""
//    let companyID = UserDefaults.standard.string(forKey: "company_id") ?? ""
//
//    var channels: [String] = []
//    channels.append("fieldslips_\(userID)_user_\(companyID)")
//    channels.append("invoice_\(userID)_user_\(companyID)")
//    channels.append("estimate_\(userID)_user_\(companyID)")
//    channels.append("customer_image_1_\(companyID)")
//    channels.append("tax_\(userID)")
//    channels.append("unit_\(userID)")
//    channels.append("unit1")
//    channels.append("measurementType")
//    channels.append("payment_\(userID)")
//    channels.append("customer1_\(companyID)")
//    channels.append("item1_\(companyID)")
//
//    return channels
//}
//
//
//
//swift
//Copy code
//import CouchbaseLiteSwift
//
//func loadUnitsWithType(_ unitType: String, completion: @escaping ([Result]? , Error?) -> Void) {
//    startPullReplication { error in
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//
//        // Proceed with the original loadUnitsWithType implementation
//        let dataArray = "UnitsArray"
//        let notificationName = Notification.Name("updatedUnitss")
//
//        // Construct the query expressions
//        var customerType = Expression.property("type").equalTo(Expression.string("unit"))
//        customerType = customerType.and(Expression.property("is_deleted").notEqualTo(Expression.string("1")))
//        customerType = customerType.and(Expression.property("unit_type").equalTo(Expression.string(unitType)))
//
//        var companyIDFK = Expression.property("user_id").equalTo(Expression.string(self.userID))
//        if unitType == "pre_defined" {
//            companyIDFK = Expression.property("user_id").equalTo(Expression.string(""))
//        }
//
//        let sortOrder = Ordering.property("unit_name").ascending()
//        let id = SelectResult.expression(Meta.id)
//
//        // Create the query
//        let query = QueryBuilder.selectDistinct([id, SelectResult.all()])
//            .from(DataSource.database(self.database))
//            .where(customerType.and(companyIDFK))
//            .orderBy(sortOrder)
//
//        // Print the query
//        self.printQueryDetails(customerType: customerType, companyIDFK: companyIDFK, sortOrder: sortOrder)
//
//        do {
//            let queryResult = try query.execute()
//            var queryResultArr: [Result] = []
//            for result in queryResult {
//                queryResultArr.append(result)
//            }
//
//            let theInfo = [dataArray: queryResultArr]
//            NotificationCenter.default.post(name: notificationName, object: self, userInfo: theInfo)
//
//            completion(queryResultArr, nil)
//        } catch {
//            completion(nil, error)
//        }
//    }
//}
//
//func printQueryDetails(customerType: Expression, companyIDFK: Expression, sortOrder: Ordering) {
//    print("Customer Type: \(customerType)")
//    print("Company ID FK: \(companyIDFK)")
//    print("Sort Order: \(sortOrder)")
//}
//
//
//swift
//Copy code
//loadUnitsWithType("someUnitType") { units, error in
//    if let error = error {
//        print("Error loading units: \(error.localizedDescription)")
//        // Handle the error appropriately
//    } else if let units = units {
//        // Use the units array as needed
//        print("Loaded units: \(units)")
//    }
//}
