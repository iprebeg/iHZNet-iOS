//
//  FavoritiViewController.m
//  iHZNet
//
//  Created by test on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritiViewController.h"
#import "Favorit.h"
#import "iHZNetAppDelegate.h"
#import "HZiface.h"

@implementation FavoritiViewController

@synthesize favoritiTable;
@synthesize tvCell;
@synthesize favoriti;
@synthesize managedObjectContext;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [favoriti count];
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   return kFavoritTableViewCellHeight;
}

- (IBAction)toggleEdit:(id)sender {
    [self.favoritiTable setEditing:!self.favoritiTable.editing animated:YES];
    if (self.favoritiTable.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Delete"];
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
    [sortDescriptor release];   
    
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
    [mutableFetchResults release];  
    [request release];  
    
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

    [self.navigationController popViewControllerAnimated:YES];
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
        [alert release];
        return;
        
    }  else {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Putovanje obrisano!" message:@"Putovanje uklonjeno iz liste favorita!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
    
    
    [self.favoriti removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;

    UITableViewCell *cell = nil;
    
    static NSString *FavoritCellIdentifier = @"FavoritCellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:FavoritCellIdentifier];
        
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavoritTableViewCell" owner:self options:nil];
        if ([nib count] > 0) {
            cell = self.tvCell;
        } else {
            NSLog(@"failed to load CustomCell nib file!");
        }     
    }
        
    UILabel *odKolLabel = (UILabel *)[cell viewWithTag:kFavOdKolodvorTag];
    UILabel *doKolLabel = (UILabel *)[cell viewWithTag:kFavDoKolodvorTag];
    
    Favorit *favorit = [favoriti objectAtIndex:row];
    
    odKolLabel.text = [favorit nazivOdlazniKolodvor];
    doKolLabel.text = [favorit nazivDolazniKolodvor];
        
    return cell;
}       


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Favoriti";
    }
    return self;
}


#pragma mark - View lifecycle

-(void) viewWillAppear:(BOOL)animated
{
    [self fetchRecords];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
    favoritiTable.backgroundColor = [UIColor clearColor];
    favoritiTable.opaque = NO;
    favoritiTable.backgroundView = nil;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(toggleEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
    
    iHZNetAppDelegate *appDelegate = (iHZNetAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
