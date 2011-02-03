//
//  ChangeUrlViewController.m
//  izicoloc
//
//  Created by rt on 03/02/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import "ChangeUrlViewController.h"


@implementation ChangeUrlViewController
@synthesize link;
@synthesize subtitle;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil paramName:(NSString *) theUrlName {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		urlName = [theUrlName retain];
	
		NSLog(@"%@", urlName);
		self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


#pragma mark -
#pragma mark Link management

// Copy the link from the pasteboard into the field
-(IBAction) copyFromClipboard:(id) sender {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	link.text = pasteboard.string;
}

-(IBAction) saveLink:(id) sender {
	NSString* URL = link.text;
	
	// Save the link
	[[NSUserDefaults standardUserDefaults] setObject:URL forKey:urlName];

	// Close the modal view
	[self dismiss:nil];
}

-(IBAction) dismiss:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSString* url = [[[NSUserDefaults standardUserDefaults] stringForKey:urlName] retain];
	// Display subtitle (url name)
	if (urlName == @"urlCourses") {
		subtitle.text = @"Adresse de la liste des courses";
	} else {
		subtitle.text = @"Adresse du suivi des dépenses";
	}
	
	// Display old URL if exists
	if (url != nil) {
		link.text = url;
	}
	[url release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[urlName retain];
    [super viewDidUnload];
}


- (void)dealloc {
	[link release];
    [super dealloc];
}


@end
