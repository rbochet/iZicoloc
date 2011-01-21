//
//  ParameterViewController.h
//  izicoloc
//
//  Created by rt on 20/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface ParameterViewController : UITableViewController {
	NSArray* colocs;
	NSDictionary *identite; 
	NSArray* fichiers;
}

@end
