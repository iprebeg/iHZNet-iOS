    //
//  KolodvorViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KolodvorViewController.h"
#import "HZiface.h"
#import "Indicators.h"
#import "Kolodvor.h"
#import "RezultatiParser.h"

#import <QuartzCore/QuartzCore.h>

@implementation KolodvorViewController

@synthesize kolodvoriTable;
@synthesize kolodvori;
@synthesize kolodvoriFiltered;
@synthesize savedSearchTerm;

- (void)viewDidLoad {
    
    [self.view layer].cornerRadius = 10;
    
     HZiface *iface = [HZiface sharedHZiface];
    
    self.kolodvori = iface.kolodvori;
    	
	if([self savedSearchTerm])
		[[[self searchDisplayController] searchBar] setText:[self savedSearchTerm]];
	
    [super viewDidLoad];
}

- (void)handleSearchForTerm:(NSString*)searchTerm
{
	[self setSavedSearchTerm:searchTerm];
		
	if ([self kolodvoriFiltered] == nil) {
		NSMutableArray *array = [[NSMutableArray alloc]init];
		[self setKolodvoriFiltered:array];
	}
	
	[[self kolodvoriFiltered] removeAllObjects];
	
	if ([[self savedSearchTerm] length] != 0)
	{
        for (Kolodvor *kolodvor in [self kolodvori])
        {
            
            if ([[kolodvor naziv] rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [[self kolodvoriFiltered] addObject:kolodvor];
            }
        }
    }
}

-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section {
	
	NSInteger rows;
	
	if (tableView == [[self searchDisplayController ] searchResultsTableView])
		rows = [[self kolodvoriFiltered] count];
	else 
		rows = [[self kolodvori] count];
	
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSInteger row = [indexPath row];
	NSString *contentForThisRow = nil;
	
	if (tableView == [[self searchDisplayController ] searchResultsTableView])
		contentForThisRow = [[kolodvoriFiltered objectAtIndex:row] naziv];
	else 
		contentForThisRow = [[kolodvori objectAtIndex:row] naziv];
	
	
	static NSString *CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier];
	}
	
	[[cell textLabel] setText:contentForThisRow];
	return cell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{	
	savedSearchTerm = @"";
}

- (BOOL) searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
	[self handleSearchForTerm:searchString];
	return YES;
}

@end
