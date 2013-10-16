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

@property (retain, nonatomic) Putovanje *currentPutovanje;
@property (retain, nonatomic) Linija *currentLinija;
@property (retain, nonatomic) Kolodvor *currentKolodvor;
@property (retain, nonatomic) Stajaliste *currentStajaliste;
@property (retain, nonatomic) Prolaziste *currentProlaziste;

@property (retain, nonatomic) NSMutableArray *currentStajalista;
@property (retain, nonatomic) NSMutableArray *currentLinije;
@property (retain, nonatomic) NSMutableArray *currentOznake;

@property (retain, nonatomic) NSMutableArray *kolodvori;
@property (retain, nonatomic) NSMutableArray *rezultati;

@property (retain, nonatomic) NSString *currentProperty;

- (BOOL)parseXML:(NSData *)xml;
- (NSMutableArray*)getRezultati;
- (NSMutableArray*)getKolodvori;
- (NSMutableArray*)getLiveInfo;


@end
