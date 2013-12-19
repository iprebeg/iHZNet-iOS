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

@property (nonatomic, strong) NSString *naziv;
@property (nonatomic, strong) NSString *vrijemeDolaska;
@property (nonatomic, strong) NSString *vrijemeOdlaska;
@property (nonatomic, strong) NSString *kasnjenjeDolaska;
@property (nonatomic, strong) NSString *kasnjenjeOdlaska;




@end
