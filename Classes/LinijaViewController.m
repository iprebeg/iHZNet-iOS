//
//  LinijaViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 12/28/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import "LinijaViewController.h"
#import "Linija.h"
#import "Stajaliste.h"
#import "LiveInfoViewController.h"



@implementation LinijaViewController

@synthesize stajalista;
@synthesize stajalistaTable;
@synthesize tvCell;
@synthesize liveInfoButton;
@synthesize linija;

- (id)initWithLinija:(Linija*)theLinija
{
    if (self = [super init])
    {
        linija = theLinija;
        stajalista = [linija stajalista];
        self.title = [linija nazivLinije];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    //NSLog(@"ima %d", [stajalista count]);
    return [stajalista count];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kStajalisteTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell = nil;
    
    static NSString *FavoritCellIdentifier = @"StajalisteCellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:FavoritCellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StajalisteTableViewCell" owner:self options:nil];
        if ([nib count] > 0) {
            cell = self.tvCell;
            //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellback"]];
        } else {
            NSLog(@"failed to load CustomCell nib file!");
        }     
    }
    
    Stajaliste *stajaliste = [stajalista objectAtIndex:row];

    UILabel *nazivLabel     = (UILabel *)[cell viewWithTag:kNazivStajalistaTag];
    UILabel *doVrijemeLabel = (UILabel *)[cell viewWithTag:kVrijemeDolaskaStajalisteTag];
    UILabel *odVrijemeLabel = (UILabel *)[cell viewWithTag:kVrijemeOdlaskaStajalisteTag];
    
    nazivLabel.text = [stajaliste nazivStajalista];
    doVrijemeLabel.text = [stajaliste vrijemeDolaskaStajaliste];
    odVrijemeLabel.text = [stajaliste vrijemeOdlaskaStajaliste];
    
    return cell;
}       


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void) viewWillAppear:(BOOL)animated
{
    }

- (void) liveInfoButtonPressed:(id)sender
{
    LiveInfoViewController *liveInfoViewController = [[LiveInfoViewController alloc] initWithLinija:linija];
    
    [self.navigationController pushViewController:liveInfoViewController animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
   
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"LiveInfo" style:UIBarButtonItemStyleBordered target:self action:@selector(liveInfoButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
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
