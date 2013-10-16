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
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * idOdlazniKolodvor;
@property (nonatomic, retain) NSNumber * idDolazniKolodvor;
@property (nonatomic, retain) NSString * nazivOdlazniKolodvor;
@property (nonatomic, retain) NSString * nazivDolazniKolodvor;

@end
