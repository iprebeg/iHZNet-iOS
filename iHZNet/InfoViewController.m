//
//  InfoViewController.m
//  iHZNet
//
//  Created by test on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "Appirater.h"
#import <SVModalWebViewController.h>

@implementation InfoViewController

- (IBAction) moreButtonPressed:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc]
                         initWithTitle:@"Poveznice" delegate:self cancelButtonTitle:@"Odustani" destructiveButtonTitle:nil otherButtonTitles:@"Prijavi problem", @"Ocijeni aplikaciju", @"Hrvatske željeznice", nil];
    
    as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [as showInView:self.view];
}

- (void) actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self reportProblem];
    }
    else if (buttonIndex == 1)
    {
        [self rateApp];
    }
    else if (buttonIndex == 2)
    {
        SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:kHZWebUrl];
        [self presentViewController:webViewController animated:YES completion:nil];
    }
    else if (buttonIndex == 4)
    {
        return;
    }
}

- (void) rateApp
{
    [Appirater rateApp];
}

- (void) reportProblem
{
    MFMailComposeViewController *controller =  [ [MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"[iHZNet] Prijava problema"];
    [controller setToRecipients:[NSArray arrayWithObject:@"iHZNet@whitebrow.net"]];
    [controller setMessageBody:@"Problem se javlja kada tražim raspored za putovanje od ... do ..., a rezultira ..." isHTML:NO];
    
    if (controller)
        [self presentViewController:controller animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
        NSLog(@"Mail sent");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
