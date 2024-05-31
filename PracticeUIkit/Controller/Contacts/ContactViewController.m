//
//  ContactViewController.m
//  PracticeUIkit
//
//  Created by ladmin on 16/05/2024.
//



#import "ContactViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface ContactViewController ()<CNContactPickerDelegate>

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)didtapAddContact:(id)sender {
    [self requestContactAccess];
}


- (void)requestContactAccess {
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [self fetchContacts];
        } else {
            NSLog(@"Access to contacts was denied");
        }
    }];
}


- (void)fetchContacts {
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *error = nil;
    
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    NSString *containerId = store.defaultContainerIdentifier;
    NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
    NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
    
    if (error) {
        NSLog(@"Error fetching contacts %@", error);
    } else {
        for (CNContact *contact in cnContacts) {
            NSString *firstName = contact.givenName;
            NSString *lastName = contact.familyName;
            NSArray *phoneNumbers = contact.phoneNumbers;
            for (CNLabeledValue *label in phoneNumbers) {
                NSString *phone = [label.value stringValue];
                NSLog(@"%@ %@: %@", firstName, lastName, phone);
            }
        }
    }
}

- (void)showContactPicker {
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    [self presentViewController:contactPicker animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    NSArray *phoneNumbers = contact.phoneNumbers;
    
    for (CNLabeledValue *label in phoneNumbers) {
        NSString *phone = [label.value stringValue];
        NSLog(@"Selected contact - %@ %@: %@", firstName, lastName, phone);
    }
}



@end
