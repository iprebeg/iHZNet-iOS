//
//  Favorit.h
//  iHZNet
//
//  Created by test on 8/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favorit : NSManagedObject {
@private
}
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSNumber * idOdlazniKolodvor;
@property (nonatomic, strong) NSNumber * idDolazniKolodvor;
@property (nonatomic, strong) NSString * nazivOdlazniKolodvor;
@property (nonatomic, strong) NSString * nazivDolazniKolodvor;

@end
