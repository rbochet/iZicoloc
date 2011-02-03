//
//  ChangeUrlViewController.h
//  izicoloc
//
//  Created by rt on 03/02/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChangeUrlViewController : UIViewController {
	UILabel* subtitle;
	UITextField* link;
	NSString* urlName;
}

@property (nonatomic, retain) IBOutlet UITextField* link;
@property (nonatomic, retain) IBOutlet UILabel* subtitle;

-(IBAction) copyFromClipboard:(id) sender;
-(IBAction) saveLink:(id) sender;
-(IBAction) dismiss:(id) sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil paramName:(NSString*)theUrlName;


@end
