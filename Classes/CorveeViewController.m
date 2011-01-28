//
//  CorveeViewController.m
//  izicoloc
//
//  Created by rt on 19/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import "CorveeViewController.h"


@implementation CorveeViewController
@synthesize picker;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Corvée";
		self.tabBarItem.image = [[UIImage imageNamed:@"corvee"] autorelease];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
	colocs = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"colocataires"]];
	[colocs insertObject:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"identite"] atIndex:0];
	[picker selectRow:5000 inComponent:0 animated:NO];
	NSLog(@"Joueurs : %@", colocs);
}


#pragma mark -
#pragma mark Choice
- (void) choose {
	srand(time(NULL));
	int randed = rand() % 1000;
	[picker selectRow:(rand() % randed) inComponent:0 animated:YES];
}
- (IBAction) buttonChoose:(id) sender {
	[self choose];
}

#pragma mark -
#pragma mark Picker
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [colocs count]*10000;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger) component {
	return [[colocs objectAtIndex:(row%[colocs count])] valueForKey:@"prenom"];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Shake detection

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
	
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.type == UIEventSubtypeMotionShake) {
		[self choose];
	}
}


@end
