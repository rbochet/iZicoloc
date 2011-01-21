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
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Paramètres";
	
	// Load the prefs
	colocs = [[NSUserDefaults standardUserDefaults] arrayForKey:@"colocataires"];
	identite = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"identite"]; 
	fichiers = [[NSUserDefaults standardUserDefaults] arrayForKey:@"fichiers"];
	
	NSLog(@"%@", identite); // NUL SI NON INIT
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
			return (2 +1); // +1 allow to add a friend
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
			cell.textLabel.text = @"Identité";
			break;
		case 1: // Each row is another guy
			switch (indexPath.row) {
				case 0: // For your identity
					cell.textLabel.text =  @"Coloc 1";
					break;
				case 1: // For the other guys
					cell.textLabel.text =  @"Coloc 2";
					break;
				case 2: // For the files (courses/suivi dépenses)
					cell.textLabel.text =  @"Ajouter coloc";
					break;
				default:
					NSLog(@"ERREUR");
					break;
			}
			break;
		case 2: // For the files (courses/suivi dépenses)
			switch (indexPath.row) {
				case 0: // Fichier comptes
					cell.textLabel.text =  @"Fichier comptes";
					break;
				case 1: // Fichier suivi des dépenses
					cell.textLabel.text =  @"Fichier dépenses";
					break;
				default:
					NSLog(@"ERREUR");
					break;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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
}


- (void)dealloc {
    [super dealloc];
}


@end

