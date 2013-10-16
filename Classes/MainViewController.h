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

@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UIButton *searchButton;
@property (retain, nonatomic) IBOutlet UITableView *izbornikTable;
@property (retain, nonatomic) OdlazniViewController *polazniController;
@property (retain, nonatomic) DolazniViewController *odredisniController;
@property (retain, nonatomic) VrijemeViewController *vrijemeController;
@property (retain, nonatomic) RezultatiViewController *rezultatiController;
@property (retain, nonatomic) FavoritiViewController *favoritiController;
@property (retain, nonatomic) InfoViewController *infoController;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  


- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)switchButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;


- (void) addFavorite;
- (void) updateFavorites;

@end
