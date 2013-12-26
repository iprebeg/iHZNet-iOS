//
//  LiveInfoViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 12/31/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import "LiveInfoViewController.h"
#import "LiveInfo.h"
#import "Indicators.h"
#import "HZiface.h"
#import "RezultatiParser.h"

@implementation LiveInfoViewController

@synthesize prolazista;
@synthesize prolazistaTable;
@synthesize linija;

static NSURLConnection *con = nil;
static NSMutableData *receivedData = nil;
static NSString *ProlazisteCellIdentifier = @"ProlazisteCellIdentifier";

- (void)configureWithLinija:(Linija*)theLinija
{
    linija = theLinija;
    self.title = [[linija nazivLinije] stringByAppendingString:@" live"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    //NSLog(@"ima %d", [prolazista count]);
    return [prolazista count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kProlazisteTableViewCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:ProlazisteCellIdentifier];
    
    Prolaziste *prolaziste = [prolazista objectAtIndex:row];
    
    UILabel *nazivLabel       = (UILabel *)[cell viewWithTag:kNazivProlazisteTag];
    UILabel *doVrijemeLabel   = (UILabel *)[cell viewWithTag:kVrijemeDolaskaProlazisteTag];
    UILabel *doKasnjenjeLabel = (UILabel *)[cell viewWithTag:kKasnjenjeDolaskaProlazisteTag];
    UILabel *odVrijemeLabel   = (UILabel *)[cell viewWithTag:kVrijemeOdlaskaProlazisteTag];
    UILabel *odKasnjenjeLabel = (UILabel *)[cell viewWithTag:kKasnjenjeOdlaskaProlazisteTag];

    
    nazivLabel.text       = [prolaziste naziv];
    doVrijemeLabel.text   = [prolaziste vrijemeDolaska];
    doKasnjenjeLabel.text = [prolaziste kasnjenjeDolaska];
    odVrijemeLabel.text   = [prolaziste vrijemeOdlaska];
    odKasnjenjeLabel.text = [prolaziste kasnjenjeOdlaska];
    
    
    return cell;
}       

-(void)getLiveInfo
{
    prolazistaTable.hidden = YES;
    
    [[Indicators sharedIndicators] start:self];
    
    //NSString *req = [NSString stringWithFormat:kLiveInfoURLString,iface.odlazniKolodvor.idKolodvora,iface.dolazniKolodvor.idKolodvora,vrijeme, iface.dv];	
    
    NSString *req = [NSString stringWithFormat:kLiveInfoURLString, linija.nazivLinije];	
    
    
    req = [req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	NSLog(@"URL: %@",req);
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:req]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:120.0];
	
	con = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    
	if (con) {
        receivedData = [NSMutableData data];
		//NSLog(@"created connection");
	} else {
		NSLog(@"failed to create connection");		
	}
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//NSLog(@"received response");
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	//NSLog(@"received some data of length %d", [data length]);
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    connection = nil;
    receivedData = nil;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UPOZORENJE!" message:@"Neuspjelo spajanje na poslužitelj!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:@"Pokušajte ponovno!",nil];	
    
    [[Indicators sharedIndicators] stop];
    
    [alert show];
    
    [[self prolazista] removeAllObjects];
    [[self prolazistaTable] reloadData];
    
	NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey] );
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//NSLog(@"Succeded loading! loaded %d bytes", [receivedData length]);
	
	RezultatiParser *rezParser = [RezultatiParser alloc]; 
    
    if (![rezParser parseXML:receivedData])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"POKUŠAJTE PONOVNO!" message:@"Live Info nije dostupan!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        [[Indicators sharedIndicators] stop];
        
        [alert show];
        
        [[self prolazista] removeAllObjects];
        [[self prolazistaTable] reloadData];
        
        return;
    }
	
	self.prolazista = [rezParser getLiveInfo];	
    [[Indicators sharedIndicators] stop];
	[[self prolazistaTable] reloadData];
    

    
    if ([self.prolazista count] == 0)
    {
        UIActionSheet *as = [[UIActionSheet alloc]
                             initWithTitle:@"Live info za traženu liniju trenutno nije dostupan!" delegate:self cancelButtonTitle:@"Povratak" destructiveButtonTitle:@"Pokušaj ponovo" otherButtonTitles:nil];
        
        as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [as showInView:self.view];
        
        
        
        return;
    }

    prolazistaTable.hidden = NO;
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        [self getLiveInfo];
    else if (buttonIndex == 1)
        [self.navigationController popViewControllerAnimated:YES];
    
}

// alert button handler
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    NSLog(@"index is %d", buttonIndex);
    
    if (buttonIndex == 0)
    {
        [[Indicators sharedIndicators] start:self];
        
		[self getLiveInfo];
		[prolazistaTable reloadData];
    }
}

- (IBAction)refreshButtonPressed:(id)sender
{
    [self getLiveInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getLiveInfo];
}

@end
