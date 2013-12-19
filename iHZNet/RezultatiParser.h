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

@interface RezultatiParser : NSObject <NSXMLParserDelegate> {
    
    Putovanje *currentPutovanje;
    Linija *currentLinija;
    Kolodvor *currentKolodvor;
    Stajaliste *currentStajaliste;
    Prolaziste *currentProlaziste;

    NSMutableArray *currentStajalista;
    NSMutableArray *currentLinije;
    NSMutableArray *currentOznake;
    
    NSMutableArray *kolodvori;
	NSMutableArray *rezultati;
    NSMutableArray *prolazista;

    NSMutableString *currentProperty;

}

@property (strong, nonatomic) Putovanje *currentPutovanje;
@property (strong, nonatomic) Linija *currentLinija;
@property (strong, nonatomic) Kolodvor *currentKolodvor;
@property (strong, nonatomic) Stajaliste *currentStajaliste;
@property (strong, nonatomic) Prolaziste *currentProlaziste;

@property (strong, nonatomic) NSMutableArray *currentStajalista;
@property (strong, nonatomic) NSMutableArray *currentLinije;
@property (strong, nonatomic) NSMutableArray *currentOznake;

@property (strong, nonatomic) NSMutableArray *kolodvori;
@property (strong, nonatomic) NSMutableArray *rezultati;

@property (strong, nonatomic) NSString *currentProperty;

- (BOOL)parseXML:(NSData *)xml;
- (NSMutableArray*)getRezultati;
- (NSMutableArray*)getKolodvori;
- (NSMutableArray*)getLiveInfo;


@end
