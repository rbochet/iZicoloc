//
//  CorveeViewController.h
//  izicoloc
//
//  Created by rt on 19/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CorveeViewController : UIViewController<UIPickerViewDataSource>{
	UIPickerView* picker;
	NSMutableArray* colocs;
}

@property (nonatomic, retain) IBOutlet UIPickerView* picker;

- (void) choose;
- (IBAction) buttonChoose:(id) sender;
	
@end
