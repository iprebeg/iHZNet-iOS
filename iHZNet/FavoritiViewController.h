//
//  FavoritiViewController.h
//  iHZNet
//
//  Created by test on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define kFavOdKolodvorTag 1
#define kFavDoKolodvorTag 2

@interface FavoritiViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource> 
{
    UITableView *favoritiTable;
    UITableViewCell *tvCell;
    NSMutableArray *favoriti;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) IBOutlet UITableView *favoritiTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *tvCell;
@property (strong, nonatomic) NSMutableArray *favoriti;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;  

- (void) fetchRecords;  
- (IBAction)toggleEdit:(id)sender;

@end  