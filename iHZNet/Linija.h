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

@property (nonatomic, strong) NSString *odlazniKolodvor;
@property (nonatomic, strong) NSString *dolazniKolodvor;
@property (nonatomic, strong) NSString *vrijemeOdlaska;
@property (nonatomic, strong) NSString *vrijemeDolaska;
@property (nonatomic, strong) NSString *nazivLinije;
@property (nonatomic, strong) NSString *trajanjeVoznje;
@property (nonatomic, strong) NSArray  *oznake;
@property (nonatomic, strong) NSArray  *stajalista;

@end
