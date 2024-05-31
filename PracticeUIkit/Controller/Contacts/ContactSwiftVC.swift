// ContactSwiftVC.swift

import UIKit
import Contacts
import ContactsUI

class ContactSwiftVC: UIViewController {

    let store = CNContactStore()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!

    var contact: CNContact?
    override func viewDidLoad() {
        super.viewDidLoad()

        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                print("Access granted")
            } else {
                print("Access denied")
            }
        }
    }

    @IBAction func didTapContact(_ sender: Any) {
        let contactsViewController = ContactsViewController()
        contactsViewController.delegate = self // Set delegate
        self.present(contactsViewController, animated: true, completion: nil)
    }
}

extension ContactSwiftVC: ContactsViewControllerDelegate {
    func didSelectContact(_ contact: CNContact) {
        // Handle the selected contact here
        print("Selected contact: \(contact.givenName)")
        nameLabel.text = contact.givenName
        for phoneNumber in contact.phoneNumbers {
            if let number = phoneNumber.value as? CNPhoneNumber {
                phoneNumberLabel.text = number.stringValue
                print("Phone Number: \(number.stringValue)")
            }
        }
        
    }
}





import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UIViewController {
    
    var contacts: [CNContact] = []
    let store = CNContactStore()
    weak var delegate: ContactsViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Contacts"
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        fetchContacts { [weak self] contacts in
            self?.contacts = contacts
            self?.tableView.reloadData()
        }
    }
    
    func fetchContacts(completion: @escaping ([CNContact]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var contacts: [CNContact] = []
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)

            do {
                try self.store.enumerateContacts(with: request) { (contact, stop) in
                    contacts.append(contact)
                }
                DispatchQueue.main.async {
                    completion(contacts)
                }
            } catch {
                print("Failed to fetch contacts:", error)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        delegate?.didSelectContact(contact)
        dismiss(animated: true, completion: nil) // Dismiss contacts view controller
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let filteredContacts = contacts.filter { contact in
                let fullName = "\(contact.givenName) \(contact.familyName)"
                return fullName.localizedCaseInsensitiveContains(searchText)
            }
            
            if searchText.isEmpty {
                fetchContacts { [weak self] contacts in
                    self?.contacts = contacts
                    self?.tableView.reloadData()
                }
            } else {
                self.contacts = filteredContacts
                self.tableView.reloadData()
            }
        }
}

protocol ContactsViewControllerDelegate: AnyObject {
    func didSelectContact(_ contact: CNContact)
}

