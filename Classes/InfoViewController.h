//
//  InfoViewController.h
//  iHZNet
//
//  Created by test on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface InfoViewController : UIViewController
<MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

{
    UIButton *rateButton;
    UIButton *reportButton;
}

@property (nonatomic, strong) IBOutlet UIButton *rateButton;
@property (nonatomic, strong) IBOutlet UIButton *reportButton;

- (IBAction)rateButtonPressed:(id)sender;
- (IBAction)reportButtonPressed:(id)sender;
- (IBAction)socialButtonPressed:(id)sender;

@end
