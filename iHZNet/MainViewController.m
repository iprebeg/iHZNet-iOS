//
//  MainViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

static BOOL backendLoaded = NO;
static NSString *CellIdentifier = @"CellIdentifier";

@implementation MainViewController

@synthesize izbornikTable;
@synthesize searchButton;
@synthesize managedObjectContext;

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {

    if (backendLoaded)
        return 3;
    else 
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
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
        contentForThisRow = @"Datum";
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterShortStyle];
        [df setTimeStyle:NSDateFormatterNoStyle];
        [df setDateFormat:(NSString*) @"dd.MM.YYYY."];
        detailsForThisRow = [df stringFromDate:iface.vrijeme];	
    }
        
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[[cell textLabel] setText:contentForThisRow];
    [[cell detailTextLabel] setText:detailsForThisRow];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = [indexPath row];    
    
    if (row == kOdlazniIndex)
    {
        [self performSegueWithIdentifier:@"odlazniSegue" sender:self];
    }
    else if (row == kDolazniIndex)
    {
        [self performSegueWithIdentifier:@"dolazniSegue" sender:self];
    }
    else if (row == kVrijemeIndex)
    {
        ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:@"Datum" datePickerMode:UIDatePickerModeDate selectedDate:[[HZiface sharedHZiface] vrijeme] target:self action:@selector(dateWasSelected:element:) origin:tableView];
        [picker showActionSheetPicker];
    }        
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element 
{    
    HZiface *iface = [HZiface sharedHZiface];
    iface.vrijeme = selectedDate;
    
    [self.izbornikTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0] ] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    backendLoaded = YES;
    //[izbornikTable reloadData];
    
    HZiface *iface = [HZiface sharedHZiface];
    [iface removeObserver:self forKeyPath:@"loaded"];
    
    [self updateFavorites];
    
    searchButton.hidden = NO;
    
    [izbornikTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    
    [Indicators dismiss];
}

- (IBAction)searchButtonPressed:(id)sender
{
    HZiface *iface = [HZiface sharedHZiface];
    iface.dv = @"D";

    //[self.navigationController pushViewController:rezultatiController animated:YES];
    [self performSegueWithIdentifier:@"rezultatiSegue" sender:self];
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;    
    
    if (![HZiface isLoaded]) 
    {
        [Indicators showWithStatus:@"Učitavanje kolodvora - molimo pričekajte"];
        
        searchButton.hidden = YES;
        
        HZiface *iface = [HZiface sharedHZiface];
    
        [iface addObserver:self forKeyPath:@"loaded" options:NSKeyValueObservingOptionOld context:nil];
    
    }
    
    [super viewDidLoad];
    
    [izbornikTable reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [izbornikTable reloadData];
}

@end
