//
//  Kolodvor.h
//  iHZNet
//
//  Created by test on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Kolodvor : NSObject {

    NSUInteger idKolodvora;
    NSString *naziv;
    
}

@property (nonatomic) NSUInteger idKolodvora;
@property (nonatomic, retain) NSString *naziv;


@end
