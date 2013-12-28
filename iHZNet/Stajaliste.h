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

@property (nonatomic, strong) NSString *nazivStajalista;
@property (nonatomic, strong) NSString *vrijemeOdlaskaStajaliste;
@property (nonatomic, strong) NSString *vrijemeDolaskaStajaliste;

@end
