//
//  Indicators.m
//  iHZNet
//
//  Created by Ivor Prebeg on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Indicators.h"

@implementation Indicators

+ (void) showWithStatus:(NSString *)status
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
}

+ (void) show
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

+ (void) dismiss
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [SVProgressHUD dismiss];
}

@end
