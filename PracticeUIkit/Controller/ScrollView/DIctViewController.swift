////
////  TestViewController.swift
////  InoviceApp
////
////  Created by ladmin on 17/05/2024.
////
//
//import UIKit
//
//class TestViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //        CouchbaseManager.sharedInstance().couchBaseSetup()
//        if let pendingInvoices = CouchbaseManager.sharedInstance().loadInvoices("pending") {
//             
//            for index in pendingInvoices {
//                let queryResult = index as! CBLQueryResult
//                
//                let invoiceDic:CBLDictionary = queryResult.value(forKey: "invoice") as! CBLDictionary
//                let customerDic:CBLDictionary = queryResult.value(forKey: "customer") as! CBLDictionary
//                if let amount = invoiceDic.value(forKey: "total_price") as? String {
//                   
//                }
//                let id = queryResult.value(forKey: "_id")
//                let invoice = queryResult.value(forKey: "invoice")
//                let customer = queryResult.value(forKey: "customer")
//                
////                if let amountSku = invoiceDic.value(forKey: "fs_sku_id"){
////                   print("Amount: \(amountSkue)")
////                }
////
////                for invoice in invoiceDic.keys{
////                    print("Invouce : \(invoice)")
////                }
//                
//                let invoiceModel = InvoiceModel(invoiceDic: invoiceDic)
//                
//                for customer in customerDic.keys {
//                    if let amountSku = customerDic.value(forKey: customer){
////                       print("CustomerKey: \(customer), Value: \(amountSku)")
//                    }
//                    
//                }
//                
//                let values = invoiceModel.getAllValues()
//                print("Valus: \(values)")
////
//                
////                for invoice in invoiceDic.keys {
////                    if let amountSku = invoiceDic.value(forKey: invoice){
////                       print("Key: \(invoice), Value: \(amountSku)")
////                    }
////
////                }
//                
////                print("PendingInvoice: \(id), invoice: \(invoice), customer: \(customer)")
//            
//            }
//        }
//    }
//}
//
//
//
//
//
//
//class InvoiceModel {
//    let invoiceDic: CBLDictionary?
//
//    init(invoiceDic: CBLDictionary?) {
//        self.invoiceDic = invoiceDic
//    }
//
//    private func getStringValue(key: String) -> String? {
//        let value = invoiceDic?.string(forKey: key)
//        print("Key: \(key), Value: \(value ?? "nil")")
//        return value
//    }
//    
//    func getAllValues() -> String? {
//        guard let invoiceDic = self.invoiceDic else {
//            return nil
//        }
//        var values = ""
//        for key in invoiceDic.keys {
//            if let amountSku = invoiceDic.value(forKey: key) as? String {
//                values += amountSku
//            }
//            
//        }
//        return values
//        
//    }
//    // Add methods for each key
//    func aboutThisCustomer() -> String? {
//        return getStringValue(key: "about_this_customer")
//    }
//    
//    func billAddressAddr1() -> String? {
//        return getStringValue(key: "billaddress_addr1")
//    }
//
//    func billAddressAddr1Ig() -> String? {
//        return getStringValue(key: "billaddress_addr1_ig")
//    }
//
//    func billAddressAddr2() -> String? {
//        return getStringValue(key: "billaddress_addr2")
//    }
//
//    func billAddressAddr2Ig() -> String? {
//        return getStringValue(key: "billaddress_addr2_ig")
//    }
//
//    func billAddressCity() -> String? {
//        return getStringValue(key: "billaddress_city")
//    }
//
//    func billAddressCityIg() -> String? {
//        return getStringValue(key: "billaddress_city_ig")
//    }
//
//    func billAddressCountry() -> String? {
//        return getStringValue(key: "billaddress_country")
//    }
//
//    func billAddressCountryIg() -> String? {
//        return getStringValue(key: "billaddress_country_ig")
//    }
//
//    func billAddressPostalCode() -> String? {
//        return getStringValue(key: "billaddress_postal_code")
//    }
//
//    func billAddressPostalCodeIg() -> String? {
//        return getStringValue(key: "billaddress_postal_code_ig")
//    }
//
//    func billAddressState() -> String? {
//        return getStringValue(key: "billaddress_state")
//    }
//
//    func billAddressStateIg() -> String? {
//        return getStringValue(key: "billaddress_state_ig")
//    }
//
//    func channels() -> String? {
//        return getStringValue(key: "channels")
//    }
//
//    func companyIdFk() -> String? {
//        return getStringValue(key: "company_id_fk")
//    }
//
//    func companyName() -> String? {
//        return getStringValue(key: "company_name")
//    }
//
//    func countryCode() -> String? {
//        return getStringValue(key: "country_code")
//    }
//
//    func email() -> String? {
//        return getStringValue(key: "email")
//    }
//
//    func firstName() -> String? {
//        return getStringValue(key: "first_name")
//    }
//
//    func fullName() -> String? {
//        return getStringValue(key: "full_name")
//    }
//
//    func geocodeError() -> String? {
//        return getStringValue(key: "geocode_error")
//    }
//
//    func igSyncErrorCode() -> String? {
//        return getStringValue(key: "ig_sync_error_code")
//    }
//
//    func igSyncErrorMessage() -> String? {
//        return getStringValue(key: "ig_sync_error_message")
//    }
//
//    func isActive() -> String? {
//        return getStringValue(key: "is_active")
//    }
//
//
//    func lastName() -> String? {
//        return getStringValue(key: "last_name")
//    }
//
//    func latitude() -> String? {
//        return getStringValue(key: "latitude")
//    }
//
//    func listId() -> String? {
//        return getStringValue(key: "list_id")
//    }
//
//    func longitude() -> String? {
//        return getStringValue(key: "longitude")
//    }
//
//    func phone() -> String? {
//        return getStringValue(key: "phone")
//    }
//
//    func platform() -> String? {
//        return getStringValue(key: "platform")
//    }
//
//    func shipAddressCountryIg() -> String? {
//        return getStringValue(key: "shipaddress__country_ig")
//    }
//
//    func shipAddressAddr1() -> String? {
//        return getStringValue(key: "shipaddress_addr1")
//    }
//
//    func shipAddressAddr1Ig() -> String? {
//        return getStringValue(key: "shipaddress_addr1_ig")
//    }
//
//    func shipAddressAddr2() -> String? {
//        return getStringValue(key: "shipaddress_addr2")
//    }
//
//    func shipAddressAddr2Ig() -> String? {
//        return getStringValue(key: "shipaddress_addr2_ig")
//    }
//
//    func shipAddressCity() -> String? {
//        return getStringValue(key: "shipaddress_city")
//    }
//
//    func shipAddressCityIg() -> String? {
//        return getStringValue(key: "shipaddress_city_ig")
//    }
//
//    func shipAddressCountry() -> String? {
//        return getStringValue(key: "shipaddress_country")
//    }
//
//    func shipAddressPostalCode() -> String? {
//        return getStringValue(key: "shipaddress_postal_code")
//    }
//
//    func shipAddressPostalCodeIg() -> String? {
//        return getStringValue(key: "shipaddress_postal_code_ig")
//    }
//
//    func shipAddressState() -> String? {
//        return getStringValue(key: "shipaddress_state")
//    }
//
//    func shipAddressStateIg() -> String? {
//        return getStringValue(key: "shipaddress_state_ig")
//    }
//
//    func type() -> String? {
//        return getStringValue(key: "type")
//    }
//
//    func userId() -> String? {
//        return getStringValue(key: "user_id")
//    }
//}
//
