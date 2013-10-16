//
//  KolodvorViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KolodvorViewController : UIViewController 
	<UITableViewDelegate, UITableViewDataSource,
	UISearchDisplayDelegate, UISearchBarDelegate> 
{
    
	UITableView *kolodvoriTable;
	NSArray *kolodvori;
	NSMutableArray *kolodvoriFiltered;
	NSString *savedSearchTerm;
}
	
	
@property (retain, nonatomic) IBOutlet UITableView *kolodvoriTable;
@property (retain, nonatomic) NSArray *kolodvori;
@property (retain, nonatomic) NSMutableArray *kolodvoriFiltered;
@property (retain, nonatomic) NSString *savedSearchTerm;
	
-(void)handleSearchForTerm:(NSString*)searchTerm;
	
@end
