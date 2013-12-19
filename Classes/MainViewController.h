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
#import "VrijemeViewController.h"
#import "RezultatiViewController.h"
#import "FavoritiViewController.h"
#import "InfoViewController.h"

#define kOdlazniIndex 0
#define kDolazniIndex 1
#define kVrijemeIndex 2


@interface MainViewController : UIViewController 
    <UIActionSheetDelegate> 
{
    UILabel *infoLabel;
    UIToolbar *toolbar;
    UIButton *searchButton;
    UITableView *izbornikTable;
    OdlazniViewController *polazniController;
    DolazniViewController *odredisniController;
    VrijemeViewController *vrijemeController;
    RezultatiViewController *rezultatiController;
    FavoritiViewController *favoritiController;
    InfoViewController *infoController;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITableView *izbornikTable;
@property (strong, nonatomic) OdlazniViewController *polazniController;
@property (strong, nonatomic) DolazniViewController *odredisniController;
@property (strong, nonatomic) VrijemeViewController *vrijemeController;
@property (strong, nonatomic) RezultatiViewController *rezultatiController;
@property (strong, nonatomic) FavoritiViewController *favoritiController;
@property (strong, nonatomic) InfoViewController *infoController;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;  


- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)switchButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;


- (void) addFavorite;
- (void) updateFavorites;

@end
