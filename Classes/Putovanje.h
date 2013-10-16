//
//  Putovanje.h
//  iHZNet
//
//  Created by Ivor Prebeg on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Linija.h"


@interface Putovanje : NSObject {
    BOOL expanded; /* GUI OPTION */
    BOOL izravno;
    NSUInteger brojPresjedanja;
    NSString *trajanjePutovanja;
    NSString *trajanjeVoznje;
    NSString *trajanjeCekanja;
    NSArray *linije;

}
@property (retain, nonatomic) NSArray *linije;
@property (retain, nonatomic) NSString *trajanjeCekanja;
@property (retain, nonatomic) NSString *trajanjeVoznje;
@property (retain, nonatomic) NSString *trajanjePutovanja;
@property (nonatomic) NSUInteger brojPresjedanja;
@property (nonatomic) BOOL izravno;
@property (nonatomic) BOOL expanded;

@end
