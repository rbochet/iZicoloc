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


@interface ParameterViewController : UITableViewController<ABPeoplePickerNavigationControllerDelegate> {
	
	// Userprefs structures
	NSMutableArray* colocs;		// Need to be altered : add / remove a coloc
	NSDictionary *identite;		// Do not need to be changed
	NSArray* fichiers;			// Do not need to be changed : fixed number of files
	
	// Store the index path to help when choosing the contact
	NSIndexPath *indexPathForContactChooser;
	
}

-(void) showPicker;
-(void) displayStoredData;
-(void) delParameters;

@end
