//
//  Indicators.h
//  iHZNet
//
//  Created by Ivor Prebeg on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIndicatorHeight 30

@interface Indicators : NSObject {
    UIActivityIndicatorView *activityIndicator;
    UIApplication *sharedApplication;
}

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) UIApplication *sharedApplication;

+ (Indicators *) sharedIndicators;
- (void) start:(UIViewController*)controller;
- (void) stop;

@end
