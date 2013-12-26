//
//  LinijaViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 12/28/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Linija.h"

#define kNazivStajalistaTag 1
#define kVrijemeDolaskaStajalisteTag 2
#define kVrijemeOdlaskaStajalisteTag 3

@interface LinijaViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *stajalistaTable;
@property (strong, nonatomic) NSArray *stajalista;
@property (strong, nonatomic) Linija *linija;

- (void)configureWithLinija:(Linija*)linija;
- (IBAction)liveInfoButtonPressed:(id)sender;

@end
