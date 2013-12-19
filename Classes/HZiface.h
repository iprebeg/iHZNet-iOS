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
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSArray *kolodvori;
@property (nonatomic, strong) Kolodvor *odlazniKolodvor;
@property (nonatomic, strong) Kolodvor *dolazniKolodvor;
@property (nonatomic, strong) NSDate *vrijeme;
@property (nonatomic, strong) NSString *dv;

- (void)loadKolodvori;
+ (HZiface *) sharedHZiface;
+ (BOOL) isLoaded;

@end
