//
//  DirectContactVC.swift
//  PracticeUIkit
//
//  Created by ladmin on 16/05/2024.
//

import UIKit
import Contacts
import ContactsUI

class DirectContactVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func openContact(contact: CNContact) {
        let contactViewController = CNContactViewController(for: contact)
        contactViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: contactViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func didtapContact(_ sender: Any) {
        // Fetch a contact from iCloud
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        fetchRequest.predicate = nil // Fetch all contacts
        
        do {
            try store.enumerateContacts(with: fetchRequest) { (contact, _) in
                // Assuming you want to open the first contact found in iCloud
                self.openContact(contact: contact)
                print("Tapped contact: \(contact.givenName) \(contact.familyName)  \(contact.phoneNumbers)")
                // If you want to open a specific contact, you need to identify it here
                // and then call openContact(contact:) with the identified contact
            }
        } catch {
            print("Failed to fetch contacts:", error)
        }
    }
}

extension DirectContactVC: CNContactViewControllerDelegate {
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        dismiss(animated: true, completion: nil)
    }
}

