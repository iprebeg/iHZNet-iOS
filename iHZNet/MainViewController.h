//
//  MainViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


#import "OdlazniViewController.h"
#import "DolazniViewController.h"
#import "RezultatiViewController.h"
#import "FavoritiViewController.h"
#import "InfoViewController.h"
#import <ActionSheetPicker-3.0/ActionSheetDatePicker.h>
#import "HZiface.h"
#import "Appirater.h"
#import "AppDelegate.h"
#import "Favorit.h"
#import "Indicators.h"

#define kOdlazniIndex 0
#define kDolazniIndex 1
#define kVrijemeIndex 2

@interface MainViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITableView *izbornikTable;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;  


- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)switchButtonPressed:(id)sender;

- (void) addFavorite;
- (void) updateFavorites;

@end
