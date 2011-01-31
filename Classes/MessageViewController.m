//
//  MessageViewController.m
//  izicoloc
//
//  Created by rt on 19/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import "MessageViewController.h"


@implementation MessageViewController
@synthesize message;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Message";
		
		self.tabBarItem.image = [[UIImage imageNamed:@"message"] autorelease];
		
		UIBarButtonItem *homeButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)] autorelease];
		self.navigationItem.leftBarButtonItem = homeButton;
	
		UIBarButtonItem *clearButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:(self) action:@selector(clearText)] autorelease];
		self.navigationItem.rightBarButtonItem = clearButton;
    }
    return self;
}
		
		
/*
-(void)awakeFromNib {
	[[NSNotificationCenter defaultCenter] addObserver:self
										selector:@selector(textedit)
										name:UITextViewTextDidBeginEditingNotification
										object:message];
}
-(void)textedit{ 
	[message setFrame:CGRectMake(0, 49, 320, 170)];
}

*/
- (IBAction) sendMail:(id)sender {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	//Check if the iDevice can send e-mails
	if ([MFMailComposeViewController canSendMail]){
		
		//Get the recipients' emails (in a NSArray) and the sender's first name
		NSDictionary* identite = [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"identite"]];
		NSString* prenom =  (NSString*) [identite valueForKey:@"prenom"];
		colocs = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"colocataires"]];
		NSMutableArray* emails = [[NSMutableArray alloc] init];
		for (int i = 0; i < [colocs count]; i++) {
			[emails insertObject:[[colocs objectAtIndex:(i)] valueForKey:@"email"] atIndex:i];
		}
		
		//Compose the email
		[controller setSubject:[@"[iZicoloc] Message de " stringByAppendingString: prenom]];
		[controller setMessageBody:message.text isHTML:YES];
		[controller setToRecipients:emails];
		controller.mailComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
		
		//Release Data
		[prenom release];
		[identite release];
		[emails release];
		[colocs release];
	}
}

- (IBAction) sendSMS:(id)sender {
	MFMessageComposeViewController* controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	// Check if the iDevice can send SMS
	if([MFMessageComposeViewController canSendText]){
		
		//Get the recipients' phone numbers (in a NSArray)
		colocs = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"colocataires"]];
		NSMutableArray* phoneNumbers = [[NSMutableArray alloc] init];
		for (int i = 0; i < [colocs count]; i++) {
			[phoneNumbers insertObject:[[colocs objectAtIndex:(i)] valueForKey:@"phone"] atIndex:i];
		}
		
		//Compose the SMS
		[controller setBody:message.text];
		[controller setRecipients:phoneNumbers];
		controller.messageComposeDelegate = self;
		
		[self presentModalViewController:controller animated:YES];
		
		//Release Data
		[phoneNumbers release];
		[colocs release];	
	}	
}
 
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

-(void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	[self dismissModalViewControllerAnimated:YES];
	[controller release];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iZicolloc" message:@"Unknown Error"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
			break;
		case MessageComposeResultSent:
			
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
	[controller release];
}

// Go to the home page
-(void) hideKeyboard {
	[message resignFirstResponder];
}

// Clear the message
-(void) clearText {
	[self hideKeyboard];
	message.text=nil;
	//[message resignFirstResponder];
}

@end
