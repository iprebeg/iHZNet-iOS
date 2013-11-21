//
//  InfoViewController.m
//  iHZNet
//
//  Created by test on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "Appirater.h"

#define NESTO 1

@implementation InfoViewController

@synthesize rateButton, reportButton;

-(IBAction)rateButtonPressed:(id)sender
{
    [Appirater rateApp];
}

-(IBAction)reportButtonPressed:(id)sender
{
    MFMailComposeViewController *controller =  [ [MFMailComposeViewController alloc] init ];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"[iHZNet] Prijava problema"];
    [controller setToRecipients:[NSArray arrayWithObject:@"iHZNet@whitebrow.net"]];
    [controller setMessageBody:@"Problem se javlja kada tražim raspored za putovanje od ... do ..., a rezultira ..." isHTML:NO];
    
    if (controller)
        [self presentViewController:controller animated:YES completion:nil];
    
    [controller release];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
        NSLog(@"Mail sent");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)socialButtonPressed:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc]
                         initWithTitle:@"Poveznice" delegate:self cancelButtonTitle:@"Odustani" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Whitebrow", @"Hrvatske željeznice", nil];
    
    as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [as showInView:self.view];
    [as release];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button %d\n", buttonIndex);
    
    if (buttonIndex == 4) {
        return;
    }
    else if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.facebook.com/pages/Whitebrow/253677847988575"]];
    }
    else if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/#!/whitebrow_net"]];
    }
    else if (buttonIndex == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.whitebrow.net"]];
    }
    else if (buttonIndex == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.hznet.hr"]];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Info";

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
