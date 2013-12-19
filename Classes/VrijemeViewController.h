//
//  VrijemeViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RezultatiViewController.h"


@interface VrijemeViewController : UIViewController {
	UIDatePicker *datePicker;
}

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


@end
