//
//  RezultatiParser.h
//  iHZNet
//
//  Created by Ivor Prebeg on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Putovanje.h"
#import "Linija.h"
#import "Kolodvor.h"
#import "Stajaliste.h"
#import "Prolaziste.h"
#import "Raspored.h"

@interface RezultatiParser : NSObject <NSXMLParserDelegate> 

@property (strong, nonatomic) Putovanje *currentPutovanje;
@property (strong, nonatomic) Linija *currentLinija;
@property (strong, nonatomic) Kolodvor *currentKolodvor;
@property (strong, nonatomic) Stajaliste *currentStajaliste;
@property (strong, nonatomic) Prolaziste *currentProlaziste;

@property (strong, nonatomic) NSMutableArray *currentStajalista;
@property (strong, nonatomic) NSMutableArray *currentLinije;
@property (strong, nonatomic) NSMutableArray *currentOznake;
@property (strong, nonatomic) NSMutableArray *prolazista;

@property (strong, nonatomic) NSMutableArray *kolodvori;

@property (strong, nonatomic) NSString *currentProperty;

@property (strong, nonatomic) Raspored *raspored;

- (BOOL)parseXML:(NSData *)xml;
- (NSMutableArray*)getKolodvori;
- (NSMutableArray*)getLiveInfo;

- (Raspored*)getRaspored;

@end
