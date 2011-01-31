//
//  MessageViewController.h
//  izicoloc
//
//  Created by rt on 19/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//#import "HomeViewController.h"

@interface MessageViewController : UIViewController<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate> {
	UITextView *message;
	NSMutableArray* colocs;
}

@property (nonatomic, retain) IBOutlet UITextView *message;

- (IBAction) sendMail:(id)sender;
- (IBAction) sendSMS:(id)sender;

@end
