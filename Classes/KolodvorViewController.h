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
	
	
@property (strong, nonatomic) IBOutlet UITableView *kolodvoriTable;
@property (strong, nonatomic) NSArray *kolodvori;
@property (strong, nonatomic) NSMutableArray *kolodvoriFiltered;
@property (strong, nonatomic) NSString *savedSearchTerm;
	
-(void)handleSearchForTerm:(NSString*)searchTerm;
	
@end
