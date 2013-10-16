    //
//  VrijemeViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VrijemeViewController.h"
#import "RezultatiViewController.h"
#import "HZiface.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@implementation VrijemeViewController

@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Vrijeme";
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];

    }
    return self;
}

# pragma mark -
# pragma mark Table Delegate Methods

/*
- (void) dateChanged:(id)sender
{
}
 */

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
}

-(void) viewWillDisappear:(BOOL)animated
{
    HZiface *iface = [HZiface sharedHZiface];
    iface.vrijeme = [datePicker date];
}

-(void) viewWillAppear:(BOOL)animated
{
    // set new date every time view appears
    [datePicker setMinimumDate:[NSDate date]];
	[datePicker setDate:[NSDate date]];
}


- (void)viewDidUnload {
    self.datePicker = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [datePicker release];
	[super dealloc];
}


@end
