//
//  Linija.h
//  iHZNet
//
//  Created by Ivor Prebeg on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Linija : NSObject {
	NSString *odlazniKolodvor;
	NSString *dolazniKolodvor;
	NSString *vrijemeOdlaska;
    NSString *vrijemeDolaska;
    NSString *nazivLinije;
    NSString *trajanjeVoznje;
    NSArray  *oznake;
    NSArray  *stajalista;
}

@property (nonatomic, retain) NSString *odlazniKolodvor;
@property (nonatomic, retain) NSString *dolazniKolodvor;
@property (nonatomic, retain) NSString *vrijemeOdlaska;
@property (nonatomic, retain) NSString *vrijemeDolaska;
@property (nonatomic, retain) NSString *nazivLinije;
@property (nonatomic, retain) NSString *trajanjeVoznje;
@property (nonatomic, retain) NSArray  *oznake;
@property (nonatomic, retain) NSArray  *stajalista;

@end
