//
//  MainViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "HZiface.h"
#import "Appirater.h"
#import "iHZNetAppDelegate.h"
#import "Favorit.h"

static BOOL backendLoaded = NO;
static UIAlertView *loadingView = nil;

@implementation MainViewController

@synthesize infoLabel;
@synthesize toolbar;
@synthesize polazniController;
@synthesize odredisniController;
@synthesize vrijemeController;
@synthesize rezultatiController;
@synthesize izbornikTable;
@synthesize searchButton;
@synthesize favoritiController;
@synthesize infoController;
@synthesize managedObjectContext;

#pragma mark -
#pragma mark TableView Handling

-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section {

    if (backendLoaded)
        return 3;
    else 
        return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleValue1
				 reuseIdentifier:CellIdentifier];
	}
	
    HZiface *iface = [HZiface sharedHZiface];
	NSUInteger row = [indexPath row];
    
	NSString *contentForThisRow = nil;
    NSString *detailsForThisRow = nil;
    
    if (row == kOdlazniIndex) {
        contentForThisRow = @"Odlazak";
        detailsForThisRow = iface.odlazniKolodvor.naziv;
    } else if (row == kDolazniIndex) {
        contentForThisRow = @"Dolazak";
        detailsForThisRow = iface.dolazniKolodvor.naziv;
    } else if (row == kVrijemeIndex) {
        contentForThisRow = @"Vrijeme";
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterShortStyle];
        [df setTimeStyle:NSDateFormatterNoStyle];
        [df setDateFormat:(NSString*) @"dd.MM.YYYY."];
        detailsForThisRow = [df stringFromDate:iface.vrijeme];	
    }
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[[cell textLabel] setText:contentForThisRow];
    [[cell detailTextLabel] setText:detailsForThisRow];
    
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];    
    

    if (row == kOdlazniIndex) {
        if (polazniController == nil) {
            polazniController = [[OdlazniViewController alloc] init];
        }
        
        [self.navigationController pushViewController: polazniController animated:YES];

        
    } else if (row == kDolazniIndex) {
        if (odredisniController == nil) {
            odredisniController = [[DolazniViewController alloc] init];
        }
        
        [self.navigationController pushViewController:odredisniController animated:YES];
        
    } else if (row == kVrijemeIndex) {
        if (vrijemeController == nil) {
            vrijemeController = [[VrijemeViewController alloc] init];
        }
        
        [self.navigationController pushViewController:vrijemeController animated:YES];
    
    }        
}

#pragma mark -
#pragma mark Event Handlers for Buttons and other events

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    backendLoaded = YES;
    //[izbornikTable reloadData];
    
    HZiface *iface = [HZiface sharedHZiface];
    [iface removeObserver:self forKeyPath:@"loaded"];
    
    [self updateFavorites];
    
    toolbar.hidden = NO;
    searchButton.hidden = NO;
    
    [izbornikTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    
    [loadingView dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)searchButtonPressed:(id)sender
{   
    if (rezultatiController != nil)
    {
        rezultatiController = nil;
    }
    
    if (rezultatiController == nil) {
        rezultatiController = [[RezultatiViewController alloc] init];
    }
    
    [self.navigationController pushViewController:rezultatiController animated:YES];
}


-(IBAction)switchButtonPressed:(id)sender
{
    HZiface *iface = [HZiface sharedHZiface];
    
	Kolodvor *odKod = iface.odlazniKolodvor;
    Kolodvor *doKod = iface.dolazniKolodvor;
    Kolodvor *tmp = nil;
    
    tmp = odKod;
    odKod = doKod;
    doKod = tmp;
    
    iface.dolazniKolodvor = doKod;
    iface.odlazniKolodvor = odKod;
    
    [izbornikTable reloadData];
}

-(IBAction)favoriteAddButtonPressed:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc]
        initWithTitle:@"Dodati liniju u favorite?" delegate:self cancelButtonTitle:@"Odustani" destructiveButtonTitle:@"Dodaj" otherButtonTitles:nil];
    
    as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [as showInView:self.view];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kActionChangeIndex)
    {
        
    }
    else if (buttonIndex == kActionSwitchIndex)
        [self addFavorite];
    
}

- (void)addFavorite {   
    
    Favorit *favorit = (Favorit *)[NSEntityDescription insertNewObjectForEntityForName:@"Favorit" inManagedObjectContext:managedObjectContext];
    
    HZiface *iface = [HZiface sharedHZiface];
    
    NSNumber *idDo = [NSNumber numberWithInt:iface.dolazniKolodvor.idKolodvora];
    NSNumber *idOd = [NSNumber numberWithInt:iface.odlazniKolodvor.idKolodvora];
    
    NSString *nazDo = [NSString stringWithString:iface.dolazniKolodvor.naziv];
    NSString *nazOd = [NSString stringWithString:iface.odlazniKolodvor.naziv];
    
    favorit.idDolazniKolodvor = idDo;
    favorit.idOdlazniKolodvor = idOd;
        
    favorit.nazivDolazniKolodvor = nazDo;
    favorit.nazivOdlazniKolodvor = nazOd;
    
    /* valjda autoreleased
     */
    NSError *error;  
    UIAlertView *alert = nil;
    if(![managedObjectContext save:&error]){  
        NSLog(@"failed to save, craaaap");
        //This is a serious error saying the record  
        //could not be saved. Advise the user to  
        //try again or restart the application.   
        
        alert = [[UIAlertView alloc]
                              initWithTitle:@"UPOZORENJE!" message:@"Putovanje već spremljeno!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];	
                
        	        
    }  else {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Putovanje spremljeno!" message:@"Putovanje se nalazi u listi favorita!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    }
    
    [alert show];
}  

-(IBAction)favoriteButtonPressed:(id)sender
{
    if (favoritiController == nil) {
        favoritiController = [[FavoritiViewController alloc] init];    
    }
    
    [self.navigationController pushViewController:favoritiController animated:YES];
    
    //[self.navigationController presentModalViewController:favoritiController animated:YES];

    
}

- (IBAction)infoButtonPressed:(id)sender 
{
    if (infoController == nil) 
    {
        infoController = [[InfoViewController alloc] init];
    }
    
    [self.navigationController pushViewController:infoController animated:YES];
}






#pragma mark -
#pragma mark Initialization and Exit handling

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)updateFavorites
{
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
    
    //NSLog(@"loaded favs");
    
    HZiface *iface = [HZiface sharedHZiface];
    NSArray *kolodvori = [iface kolodvori];
    
    for (Favorit *f in mutableFetchResults)
    {
        //NSLog(@"%d %d (%@) %d (%@)", f.id.intValue, f.idOdlazniKolodvor.intValue, f.nazivOdlazniKolodvor, f.idDolazniKolodvor.intValue, f.nazivDolazniKolodvor);
       
        for (Kolodvor *k in kolodvori)
        {
            if ([[[f nazivOdlazniKolodvor] uppercaseString] isEqualToString:[[k naziv] uppercaseString]])
            {
                f.idOdlazniKolodvor = [NSNumber numberWithInt:[k idKolodvora]];
            } 
            if ([[[f nazivDolazniKolodvor] uppercaseString] isEqualToString:[[k naziv] uppercaseString]])
            {
                f.idDolazniKolodvor = [NSNumber numberWithInt:[k idKolodvora]];
            }
        }
    }
    
    [managedObjectContext save:nil];
    
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
    
    izbornikTable.backgroundColor = [UIColor clearColor];
    izbornikTable.opaque = NO;
    izbornikTable.backgroundView = nil;
    
    iHZNetAppDelegate *appDelegate = (iHZNetAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;    
    
    ////
        
    
    if (![HZiface isLoaded]) {
    
        loadingView = [[UIAlertView alloc] initWithTitle:@"Učitavanje kolodvora\nMolimo pričekajte..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [loadingView show];

        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
        // Adjust the indicator so it is up a few pixels from the bottom of the alert
        indicator.center = CGPointMake(loadingView.bounds.size.width / 2, loadingView.bounds.size.height - 50);
        [indicator startAnimating];
        [loadingView addSubview:indicator];
        ////
    
        
        toolbar.hidden = YES;
        searchButton.hidden = YES;
        
        HZiface *iface = [HZiface sharedHZiface];
    
        [iface addObserver:self forKeyPath:@"loaded" options:NSKeyValueObservingOptionOld context:nil];
    
    }
    
    [super viewDidLoad];
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"greenButton.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal
                                             stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [searchButton setBackgroundImage:stretchableButtonImageNormal
                                 forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"darkgreenButton.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed
                                              stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [searchButton setBackgroundImage:stretchableButtonImagePressed
                                 forState:UIControlStateHighlighted];    
    
    [izbornikTable reloadData];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [izbornikTable reloadData];
}

@end
