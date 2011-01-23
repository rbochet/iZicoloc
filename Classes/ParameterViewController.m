//
//  ParameterViewController.m
//  izicoloc
//
//  Created by rt on 20/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import "ParameterViewController.h"


@implementation ParameterViewController

#pragma mark -
#pragma mark Deal with stored data
- (void)displayStoredData {
	// Load the data
	NSArray *colocsL = [[NSUserDefaults standardUserDefaults] arrayForKey:@"colocataires"];
	NSDictionary *identiteL = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"identite"]; 
	NSArray *fichiersL = [[NSUserDefaults standardUserDefaults] arrayForKey:@"fichiers"];
	
	// Display  the data
	NSLog(@"---- DISPLAY STORED DATA ----");
	NSLog(@"identite : %@", identiteL);
	NSLog(@"-----------------------------");
	NSLog(@"colocs : %@", colocsL);
	NSLog(@"-----------------------------");
	NSLog(@"fichiers : %@", fichiersL);
	NSLog(@"-- END DISPLAY STORED DATA --");
}

- (void)delParameters {
	// Write nil in all the parameters
	[[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"colocataires"];
	[[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"fichiers"];
	
	// Reload the table's content
	[self.tableView reloadData];
}



#pragma mark -
#pragma mark View lifecycle

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Paramètres";
		UIBarButtonItem *resetButton = [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(delParameters)] autorelease];
		self.navigationItem.rightBarButtonItem = resetButton;
    }
    return self;
}


- (void)viewDidLoad {
	
	// TEST AREA //
/*	NSMutableDictionary* myDic = [[NSMutableDictionary alloc] init];
	[myDic setValue:@"Romain" forKey:@"prenom"];
	[myDic setValue:@"Bochet" forKey:@"nom"];
	
	NSMutableDictionary* myDic2 = [[NSMutableDictionary alloc] init];
	[myDic2 setValue:@"Thomas" forKey:@"prenom"];
	[myDic2 setValue:@"Giraud" forKey:@"nom"];
	
	NSMutableArray* myCol = [[NSMutableArray alloc] init];
	[myCol addObject:myDic];
	[myCol addObject:myDic2];
	[[NSUserDefaults standardUserDefaults] setValue:myCol forKey:@"colocataires"];
	
	[myDic release];
	[myDic2 release];
	[self displayStoredData]; */

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	// Load the prefs if they exists. Otherwise, pointers are niled.
	colocs = [[[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"colocataires"] retain];
	identite = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"identite"] retain]; 
	fichiers = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"fichiers"] retain];
	
	[self displayStoredData]; 
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisapp	ear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
		case 0: // For your identity
			return 1;
			break;
		case 1: // For the other guys
			if(colocs != nil) // All the coloc + the add line
				return [colocs count] +1; 
			else // Just the add line
				return 1;
			break;
		case 2: // For the files (courses/suivi dépenses)
			return 2;
			break;
		default:
			NSLog(@"ERREUR");
			break;
	}
	return  0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    	
    switch (indexPath.section) {
		case 0: // For your identity
			if(identite != nil) { // The identity is already set
				cell.textLabel.text = [identite objectForKey:@"prenom"];
			} else {
				cell.textLabel.text = @"Me définir";
			}
			break;
		case 1: // Each row is another guy + 1 extra line for add one more
			if(colocs != nil && indexPath.row < [colocs count]) { // The interesting coloc exists
				cell.textLabel.text = [[colocs objectAtIndex:indexPath.row] objectForKey:@"prenom"];
			} else {
				cell.textLabel.text = @"Ajouter un coloc";
			}
			break;
		case 2: // For the files (courses/suivi dépenses)
			if (fichiers == nil || [fichiers objectAtIndex:indexPath.row] == nil) { // If the array isn't defined, or the interesting one
				cell.textLabel.text = @"À définir";
			} else { // Display the good one :)
				cell.textLabel.text = [fichiers objectAtIndex:indexPath.row];
			}
			break;
		default:
			NSLog(@"ERREUR");
			break;
	}
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Deselect row
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// Store the indexpath to let the callback know which field he has to replace
	indexPathForContactChooser = indexPath;
	
	if (indexPath.section < 2) { // Edit people
		[self showPicker];
	} else { // Edit files
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pas encore implémentée" 
														message:@"Cette fonctionalité n'est pas implémentée" 
													   delegate:nil 
											  cancelButtonTitle:@"Retour aux params" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}

}

#pragma mark -
#pragma mark AddressBook Management

// Show the picker
-(void) showPicker {
    ABPeoplePickerNavigationController *picker =
	[[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	
    [self presentModalViewController:picker animated:YES];
    [picker release];
	[self.tableView reloadData];
}


- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	
	// Load data from adress book
	NSString* prenom = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	NSString* nom = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);	
	ABMutableMultiValueRef strangeMail =  ABRecordCopyValue(person, kABPersonEmailProperty);
	NSString* email =  (NSString*) ABMultiValueCopyValueAtIndex(strangeMail, 0);
	ABMutableMultiValueRef strangePhone =  ABRecordCopyValue(person, kABPersonPhoneProperty);
	NSString* phone =  (NSString*) ABMultiValueCopyValueAtIndex(strangePhone, 0);


	
	// Copy in the contact struct TODO TEL MAIL MULTIVALUE
	NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
	[dic setValue:prenom forKey:@"prenom"];
	[dic setValue:nom forKey:@"nom"];
	[dic setValue:email forKey:@"email"];
	[dic setValue:phone forKey:@"phone"];

	[prenom release];
	[nom release];
	[email release];
	[phone release];
	CFRelease(strangeMail);
	CFRelease(strangePhone);
	
	
	// Add in the right place
	if (indexPathForContactChooser.section == 0) { // Edit "identite"		
		// Set the new one
		[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"identite"];
		[self.tableView reloadData];
	} else { // Edit a coloc among "colocs"
		// Coloc number
		int numColoc = indexPathForContactChooser.row;
		
		if (colocs == nil) { // If colocs is not set (BTW, numColoc = 0)
			colocs = [[NSMutableArray alloc] init];
		}
		
		if (numColoc >= [colocs count]){
			[colocs addObject:dic];
		} else {
			[colocs replaceObjectAtIndex:numColoc withObject:dic];
		}
		
f		// Write the new coloc value
		[[NSUserDefaults standardUserDefaults] setObject:colocs forKey:@"colocataires"];
		[self.tableView reloadData];
	} 		
	

	// Release allow'd data
	[dic release];
	
	[peoplePicker dismissModalViewControllerAnimated:YES];

	return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier{
	
    return NO;
}




#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[colocs release];
	[identite release];
	[fichiers release];
	[indexPathForContactChooser release];
}


- (void)dealloc {
    [super dealloc];
}


@end

