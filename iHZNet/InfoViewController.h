//
//  InfoViewController.h
//  iHZNet
//
//  Created by test on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

- (IBAction)moreButtonPressed:(id)sender;

@end
