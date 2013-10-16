//
//  Stajaliste.h
//  iHZNet
//
//  Created by Ivor Prebeg on 12/28/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stajaliste : NSObject
{
    NSString *nazivStajalista;
    NSString *vrijemeOdlaskaStajaliste;
    NSString *vrijemeDolaskaStajaliste;
}

@property (nonatomic, retain) NSString *nazivStajalista;
@property (nonatomic, retain) NSString *vrijemeOdlaskaStajaliste;
@property (nonatomic, retain) NSString *vrijemeDolaskaStajaliste;

@end
