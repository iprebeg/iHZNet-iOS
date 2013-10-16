//
//  RezultatiViewController.h
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kOdKolodvorTag 1
#define kOdVrijemeTag  2
#define kDoKolodvorTag 3
#define kDoVrijemeTag  4
#define kLinijaTag     5
#define kTrajanjeTag   6

#define kPutOdKolodvorTag 11
#define kPutDoKolodvorTag 12
#define kPutOdVrijemeTag  13
#define kPutDoVrijemeTag  14
#define kPutBrojPresjedanjaTag   15
#define kPutTrajanjeCekanjaTag  16
#define kPutTrajanjeVoznjeTag   17
#define kPutTrajanjePutovanjaTag 18
#define kPutExpandImageTag 19

#define kOznakaTag1    21
#define kOznakaTag2    22
#define kOznakaTag3    23
#define kOznakaTag4    24
#define kOznakaTag5    25
#define kOznakaTag6    26
#define kOznakaTag7    27
#define kOznakaTag8    28

#define kActionSwitchIndex 0
#define kActionChangeIndex 1

#define kDatumTag 2

#define kLinijaCellHeight    76
#define kPutovanjeCellHeight    95

@interface RezultatiViewController : UIViewController 
	<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
	UITableView *rezultatiTable;
	NSMutableArray *rezultati;
    NSMutableData *receivedData;
    UISegmentedControl *izravniSegmented;
    UITableViewCell *tvCell;
}

@property (retain, nonatomic) NSMutableArray *rezultati;
@property (retain, nonatomic) IBOutlet UITableView *rezultatiTable;
@property (copy, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) UISegmentedControl *izravniSegmented;
@property (retain, nonatomic) IBOutlet UITableViewCell *tvCell;

@end
