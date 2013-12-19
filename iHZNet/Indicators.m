//
//  Indicators.m
//  iHZNet
//
//  Created by Ivor Prebeg on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Indicators.h"

static Indicators *shared = nil;

@implementation Indicators

@synthesize activityIndicator;
@synthesize sharedApplication;

+ (Indicators *) sharedIndicators
{
	if (!shared || shared == nil)
	{
		shared = [[Indicators alloc] init];
	}
	return shared;
}

- (void) start:(UIViewController*)controller
{
    if (activityIndicator == nil)
    {
        activityIndicator = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        CGRect mainBounds = [[UIScreen mainScreen] bounds];
        activityIndicator.frame = CGRectMake(mainBounds.size.width / 2 - (kIndicatorHeight / 2),
                                             mainBounds.size.height / 2 - (kIndicatorHeight / 2) - kIndicatorHeight, kIndicatorHeight, kIndicatorHeight);
    }
    
    if (sharedApplication == nil)
    {
        sharedApplication = [UIApplication sharedApplication];
    }
    
    [controller.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    sharedApplication.networkActivityIndicatorVisible = YES;
}

- (void) stop
{
    [activityIndicator stopAnimating];
    sharedApplication.networkActivityIndicatorVisible = NO;
}

@end
