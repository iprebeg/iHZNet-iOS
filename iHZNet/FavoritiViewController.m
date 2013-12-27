//
//  FavoritiViewController.m
//  iHZNet
//
//  Created by test on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritiViewController.h"
#import "Favorit.h"
#import "AppDelegate.h"
#import "HZiface.h"

@implementation FavoritiViewController

@synthesize favoritiTable;
@synthesize favoriti;
@synthesize managedObjectContext;

static NSString *FavoritCellIdentifier = @"FavoritCellIdentifier";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    //NSLog(@"got %d cells", [favoriti count]);
    return [favoriti count];
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   return kFavoritTableViewCellHeight;
}

- (IBAction)toggleEdit:(id)sender {
    [self.favoritiTable setEditing:!self.favoritiTable.editing animated:YES];

    if (self.favoritiTable.editing)
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
}

- (void)fetchRecords {   
    
    // Define our table/entity to use  
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorit" inManagedObjectContext:managedObjectContext];   
    
    // Setup the fetch request  
    NSFetchRequest *request = [[NSFetchRequest alloc] init];  
    [request setEntity:entity];   
    
    // Define how we will sort the records  
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];  
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    [request setSortDescriptors:sortDescriptors];  
    
    // Fetch the records and handle an error  
    NSError *error;  
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];   
    
    if (!mutableFetchResults) {  
        NSLog(@"holy crap, cant get db entry");
        // Handle the error.  
        // This is a serious error and should advise the user to restart the application  
    }
    
    // Save our fetched data to an array  
    [self setFavoriti: mutableFetchResults];  
    
    //NSLog(@"got %d cells", [favoriti count]);
    
    [favoritiTable reloadData];
}   

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;  
    
    
    Favorit *favorit = [favoriti objectAtIndex:row];
    
    //////
    HZiface *iface = [HZiface sharedHZiface];
    
    NSUInteger idDo = [favorit.idDolazniKolodvor integerValue];
    NSUInteger idOd = [favorit.idOdlazniKolodvor integerValue];

    NSString *nazDo = [NSString stringWithString:favorit.nazivDolazniKolodvor];
    NSString *nazOd = [NSString stringWithString:favorit.nazivOdlazniKolodvor];

    iface.dolazniKolodvor.naziv = nazDo;
    iface.odlazniKolodvor.naziv = nazOd;
    
    iface.dolazniKolodvor.idKolodvora = idDo;
    iface.odlazniKolodvor.idKolodvora = idOd;
    
    //////
    [self.tabBarController setSelectedIndex:0];
    //[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table View Data Source Methods
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    Favorit *favorit = [favoriti objectAtIndex:row];
    [managedObjectContext deleteObject:favorit];
    
    NSError *error;  
    UIAlertView *alert = nil;
    if(![managedObjectContext save:&error]){  
        NSLog(@"failed to save, craaaap");
        //This is a serious error saying the record  
        //could not be saved. Advise the user to  
        //try again or restart the application.   
        
        alert = [[UIAlertView alloc]
                 initWithTitle:@"UPOZORENJE!" message:@"Putovanje nije obrisano!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];	
        
        [alert show];
        return;
        
    }  else {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Putovanje obrisano!" message:@"Putovanje uklonjeno iz liste favorita!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        [alert show];
    }
    
    
    [self.favoriti removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;

    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:FavoritCellIdentifier];
        
    UILabel *odKolLabel = (UILabel *)[cell viewWithTag:kFavOdKolodvorTag];
    UILabel *doKolLabel = (UILabel *)[cell viewWithTag:kFavDoKolodvorTag];
    
    Favorit *favorit = [favoriti objectAtIndex:row];
    
    odKolLabel.text = [favorit nazivOdlazniKolodvor];
    doKolLabel.text = [favorit nazivDolazniKolodvor];
        
    return cell;
}

#pragma mark - View lifecycle

-(void) viewWillAppear:(BOOL)animated
{
    [self fetchRecords];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [super viewDidLoad];
}

@end
