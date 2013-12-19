//
//  LiveInfoViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 12/31/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prolaziste.h"
#import "Linija.h"

#define kNazivProlazisteTag 11
#define kVrijemeDolaskaProlazisteTag 12
#define kKasnjenjeDolaskaProlazisteTag 13
#define kVrijemeOdlaskaProlazisteTag 14
#define kKasnjenjeOdlaskaProlazisteTag 15

@interface LiveInfoViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    UITableView *prolazistaTable;
    UITableViewCell *tvCell;
    NSMutableArray *prolazista;
    Linija *linija;
}

@property (strong, nonatomic) Linija *linija;
@property (strong, nonatomic) IBOutlet UITableView *prolazistaTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *tvCell;
@property (strong, nonatomic) NSMutableArray *prolazista;

- (id)initWithLinija:(Linija*)linija;


@end
