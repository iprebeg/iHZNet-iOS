    //
//  RootViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "PolazniViewController.h"
#import "OdredisniViewController.h"
#import "VrijemeViewController.h"
#import "RezultatiViewController.h"

 

@implementation RootViewController

@synthesize polazniController;
@synthesize odredisniController;
@synthesize vrijemeController;
@synthesize rezultatiController;


- (IBAction)nextView:(id)sender
{
	NSLog(@"nextView called");
	if (self.polazniController.view.superview != nil)
	{	// current controller is polazni, next is odredisni
		NSLog(@"POLAZNI NOT NIL");		
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.odredisniController == nil)
		{
			OdredisniViewController *newC = [[OdredisniViewController alloc]
										   initWithNibName:@"OdredisniView" bundle:nil];
			self.odredisniController = newC;
		}
		
		// change controller
		[polazniController.view removeFromSuperview];
		[self.view insertSubview:odredisniController.view atIndex:0];		
	} 	
	else if (self.odredisniController.view.superview != nil) 
	{	// current controller is odredisni, next is vrijeme
		NSLog(@"ODREDISNI NOT NIL");
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.vrijemeController == nil)
		{
			VrijemeViewController *newC = [[VrijemeViewController alloc]
										   initWithNibName:@"VrijemeView" bundle:nil];
			self.vrijemeController = newC;
		}
		
		// change controller
		[odredisniController.view removeFromSuperview];
		[self.view insertSubview:vrijemeController.view atIndex:0];
		
	} else if (self.vrijemeController.view.superview != nil)
	{	// current controller is vrijeme, next is rezultat		
		NSLog(@"VRIJEME NOT NIL");	
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.rezultatiController == nil)
		{
			RezultatiViewController *newC = [[RezultatiViewController alloc]
										   initWithNibName:@"RezultatiView" bundle:nil];
			self.rezultatiController = newC;
		}
		
		// change controller
		[vrijemeController.view removeFromSuperview];
		[self.view insertSubview:rezultatiController.view atIndex:0];		
		
	} else if (self.rezultatiController.view.superview != nil)		
	{	// current controller is rezultati, next is none		
		NSLog(@"REZULTATI NOT NIL");	
		
		/*
		// in case next controller is not yet loaded or unloaded, load it
		if (self.vrijemeController == nil)
		{
			VrijemeViewController *newC = [[VrijemeViewController alloc]
										   initWithNibName:@"VrijemeView" bundle:nil];
			self.vrijemeController = newC;
		}
		
		// change controller
		[odredisniController.view removeFromSuperview];
		[self.view insertSubview:vrijemeController.view atIndex:0];		
		*/
	}		
	NSLog(@"nextView finished");	
}


- (IBAction)prevView:(id)sender
{
	NSLog(@"nextView called");
	
	if (self.rezultatiController.view.superview != nil)		
	{	// current controller is rezultati, prev is vrijeme		
		NSLog(@"REZULTATI NOT NIL");	
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.vrijemeController == nil)
		{
			VrijemeViewController *newC = [[VrijemeViewController alloc]
										   initWithNibName:@"VrijemeView" bundle:nil];
			self.vrijemeController = newC;
		}
		 
		// change controller
		[rezultatiController.view removeFromSuperview];
		[self.view insertSubview:vrijemeController.view atIndex:0];		
	
	} else if (self.vrijemeController.view.superview != nil)
	{	// current controller is vrijeme, prev is odredisni		
		NSLog(@"VRIJEME NOT NIL");	
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.odredisniController == nil)
		{
			OdredisniViewController *newC = [[OdredisniViewController alloc]
											 initWithNibName:@"OdredisniView" bundle:nil];
			self.odredisniController = newC;
		}
		
		// change controller
		[vrijemeController.view removeFromSuperview];
		[self.view insertSubview:odredisniController.view atIndex:0];		
		
	}
 	
	else if (self.odredisniController.view.superview != nil) 
	{	// current controller is odredisni, prev is polazni
		NSLog(@"ODREDISNI NOT NIL");
		
		// in case next controller is not yet loaded or unloaded, load it
		if (self.polazniController == nil)
		{
			PolazniViewController *newC = [[PolazniViewController alloc]
										   initWithNibName:@"PolazniView" bundle:nil];
			self.polazniController = newC;
		}
		
		// change controller
		[odredisniController.view removeFromSuperview];
		[self.view insertSubview:polazniController.view atIndex:0];
		
	}
	
	else if (self.polazniController.view.superview != nil)
	{	// current controller is polazni, prev is none
		NSLog(@"POLAZNI NOT NIL");		
		
		/*
		// in case next controller is not yet loaded or unloaded, load it
		if (self.odredisniController == nil)
		{
			OdredisniViewController *newC = [[OdredisniViewController alloc]
											 initWithNibName:@"OdredisniView" bundle:nil];
			self.odredisniController = newC;
		}
		
		// change controller
		[polazniController.view removeFromSuperview];
		[self.view insertSubview:odredisniController.view atIndex:0];		
		 */
	} 	
		
	NSLog(@"nextView finished");		
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSLog(@"I IS HERE");
	
	PolazniViewController *polazniC = [[PolazniViewController alloc]
									   initWithNibName:@"PolazniView" bundle:nil];
	self.polazniController = polazniC;
	[self.view insertSubview:polazniC.view atIndex:0];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	if (self.polazniController.view.superview == nil)
		self.polazniController = nil;
	
	if (self.odredisniController.view.superview == nil)
		self.odredisniController = nil;
	
	if (self.vrijemeController.view.superview == nil)
		self.vrijemeController = nil;
	
	if (self.rezultatiController.view.superview == nil)
		self.rezultatiController = nil;
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
