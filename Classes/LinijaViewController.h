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

@interface LinijaViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *stajalistaTable;
    UITableViewCell *tvCell;
    NSArray *stajalista;
    UIButton *liveInfoButton;
    Linija *linija;
}

@property (strong, nonatomic) IBOutlet UITableView *stajalistaTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *tvCell;
@property (strong, nonatomic) NSArray *stajalista;
@property (strong, nonatomic) UIButton *liveInfoButton;
@property (strong, nonatomic) Linija *linija;


- (id)initWithLinija:(Linija*)linija;

@end
