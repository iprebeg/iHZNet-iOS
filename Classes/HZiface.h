//
//  HZiface.h
//  iHZNet
//
//  Created by Ivor Prebeg on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RezultatiViewController.h"
#import "Kolodvor.h"

@interface HZiface : NSObject {
    
    BOOL loaded;
    NSMutableData *receivedData;
    NSArray *kolodvori;
    Kolodvor *odlazniKolodvor;
    Kolodvor *dolazniKolodvor;
	NSDate *vrijeme;
    NSString *dv;
}

@property (nonatomic) BOOL loaded;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSArray *kolodvori;
@property (nonatomic, retain) Kolodvor *odlazniKolodvor;
@property (nonatomic, retain) Kolodvor *dolazniKolodvor;
@property (nonatomic, retain) NSDate *vrijeme;
@property (nonatomic, retain) NSString *dv;

- (void)loadKolodvori;
+ (HZiface *) sharedHZiface;
+ (BOOL) isLoaded;

@end
