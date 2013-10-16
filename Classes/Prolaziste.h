//
//  Prolaziste.h
//  iHZNet
//
//  Created by Ivor Prebeg on 12/31/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prolaziste : NSObject
{
    NSString *naziv;
    NSString *vrijemeDolaska;
    NSString *vrijemeOdlaska;
    NSString *kasnjenjeDolaska;
    NSString *kasnjenjeOdlaska;
}

@property (nonatomic, retain) NSString *naziv;
@property (nonatomic, retain) NSString *vrijemeDolaska;
@property (nonatomic, retain) NSString *vrijemeOdlaska;
@property (nonatomic, retain) NSString *kasnjenjeDolaska;
@property (nonatomic, retain) NSString *kasnjenjeOdlaska;




@end
