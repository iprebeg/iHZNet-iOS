//
//  RezultatiViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RezultatiViewController.h"
#import "HZiface.h"
#import "Putovanje.h"
#import "Indicators.h"
#import "Linija.h"
#import "RezultatiParser.h"
#import "LinijaViewController.h"
#import "LiveInfoViewController.h"

@implementation RezultatiViewController

@synthesize rezultati;
@synthesize rezultatiTable;
@synthesize receivedData;
@synthesize izravniSegmented;
@synthesize waitpoll_count;

static NSURLConnection *con = nil;

static NSString *LinijaCellIdentifier = @"LinijaCellIdentifier";
static NSString *PutovanjeCellIdentifier = @"PutovanjeCellIdentifier";

-(void)getRezultati
{
    [Indicators show];

    HZiface *iface = [HZiface sharedHZiface];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    [df setDateFormat:(NSString*) @"dd.MM.YY"];
    
    NSString *vrijeme = [df stringFromDate:iface.vrijeme];	
    
    NSString *req = [NSString stringWithFormat:kURLString,iface.odlazniKolodvor.idKolodvora,iface.dolazniKolodvor.idKolodvora,vrijeme, iface.dv];	
    
    req = [req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	//NSLog(@"URL: %@",req);
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:req]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:10.0];
	
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
    
    [Indicators show];
    
    [alert show];
    
    [[self rezultati] removeAllObjects];
    [[self rezultatiTable] reloadData];
    
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
                              initWithTitle:@"POKUŠAJTE PONOVNO!" message:@"Nisu pronađena izravna putovanja!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        [Indicators dismiss];
        
        [alert show];
        
        [[self rezultati] removeAllObjects];
        [[self rezultatiTable] reloadData];
        
        return;
    }
	

    Raspored *raspored = [rezParser getRaspored];
    if ([raspored waitpoll] == true && waitpoll_count < 5)
    {
      waitpoll_count++;
      [self performSelector:@selector(getRezultati) withObject:nil afterDelay:11.0];
      return;
    }
    waitpoll_count = 0;

  self.rezultati = [raspored putovanja];	
  [Indicators dismiss];
  [[self rezultatiTable] reloadData];
    
    
    NSString *segmentButtonTitle = nil;
    if (izravniSegmented.selectedSegmentIndex == 0) {
        segmentButtonTitle = @"S presjedanjem";
    } else {
        segmentButtonTitle = @"Izravni";
    }  
        
    if ([self.rezultati count] == 0)
    {
        UIActionSheet *as = [[UIActionSheet alloc]
                              initWithTitle:@"Nisu pronađena putovanja!" delegate:self cancelButtonTitle:segmentButtonTitle destructiveButtonTitle:@"Promijeni pretragu" otherButtonTitles:nil];
        
        [as showFromTabBar:self.tabBarController.tabBar];
        
        return;
    }
    
    HZiface *iface = [HZiface sharedHZiface];
     
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    [df setDateFormat:(NSString*) @"dd.MM.YYYY."];
    NSString *datum = [df stringFromDate:iface.vrijeme];	

    UILabel *datumLabel = (UILabel *)[self.view viewWithTag:kDatumTag];
    datumLabel.text = datum;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [Indicators show];
        
		[self getRezultati];
		[rezultatiTable reloadData];
    }
}

- (void) viewDidLoad
{
    waitpoll_count = 0;

    rezultati = [[NSMutableArray alloc] init ];
    
    [izravniSegmented addTarget:self action:@selector(changedSegment)
               forControlEvents:UIControlEventValueChanged];

    [rezultatiTable reloadData];
    
    [self getRezultati];
    ///
}

- (void) changedSegment
{
    HZiface *iface = [HZiface sharedHZiface];
    
    if (izravniSegmented.selectedSegmentIndex == 0) {
        iface.dv = @"D";
    } else {
        iface.dv = @"S";
    }
    
    [con cancel];
    [Indicators dismiss];
    
    [self getRezultati];
}

- (void) changeSegment
{
    
    if (izravniSegmented.selectedSegmentIndex == 0) {
        izravniSegmented.selectedSegmentIndex = 1;
    } else {
        izravniSegmented.selectedSegmentIndex = 0;
    }
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 5.0) {
        [izravniSegmented sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [con cancel];
    [Indicators dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    Putovanje *putovanje = [rezultati objectAtIndex:section];
    if ([putovanje izravno] || (![putovanje izravno] && row != 0))
        return kLinijaCellHeight;
    else
        return kPutovanjeCellHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"there is %d rez", [rezultati count]);
	return [rezultati count]; 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *sectionHeader = [[[[rezultati objectAtIndex:section] linije] objectAtIndex:0] vrijemeOdlaska];
  	return sectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger row = indexPath.row;  
    NSUInteger section = indexPath.section;
    
    Putovanje *putovanje = [rezultati objectAtIndex:section];
    
    if ([putovanje izravno] || row != 0)
    {
        NSUInteger index  = [putovanje izravno] ? 0 : (row - 1);
        
        _selectedLinija = [[putovanje linije] objectAtIndex:index];
        
        [self performSegueWithIdentifier:@"linijaSegue" sender:self];
        
        return;
    }
    
    if (row == 0)  {
        
        if (![putovanje izravno] && [putovanje expanded]) {
            putovanje.expanded = NO;
        }
        else if (![putovanje izravno] && ![putovanje expanded]) { 
            putovanje.expanded = YES;
        }
        
      
        [rezultatiTable reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"linijaSegue"])
    {
        LinijaViewController *linijaVC = (LinijaViewController *)segue.destinationViewController;
        if (_selectedLinija != nil && linijaVC != nil)
        {
            [linijaVC configureWithLinija:_selectedLinija];
        }
    }
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	
    Putovanje *putovanje = [rezultati objectAtIndex:section];
    NSUInteger num = 0;
    
    if ([putovanje izravno])
        num = [putovanje.linije count];
    else if (![putovanje izravno] && [putovanje expanded])
        num = [putovanje.linije count] + 1;
    else if (![putovanje izravno] && ![putovanje expanded])        
        num = 1;
    
    return num;
}	


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    
    Putovanje *putovanje = [rezultati objectAtIndex:section];
    Linija *linija = nil;
    
    if ([putovanje izravno])
        linija = [putovanje.linije objectAtIndex:row ];
    else if (![putovanje izravno] && row != 0)
        linija = [putovanje.linije objectAtIndex:(row - 1)];
    else
        linija = nil;
    
    UITableViewCell *cell = nil;
    
    if (linija != nil)
    {	
        //NSLog(@"showing linija");
        
        /* cell je Linija */
        cell = [tableView dequeueReusableCellWithIdentifier:LinijaCellIdentifier];
    
        UILabel *odKolLabel = (UILabel *)[cell viewWithTag:kOdKolodvorTag];
        UILabel *doKolLabel = (UILabel *)[cell viewWithTag:kDoKolodvorTag];
        UILabel *odVrijemeLabel = (UILabel *)[cell viewWithTag:kOdVrijemeTag];
        UILabel *doVrijemeLabel = (UILabel *)[cell viewWithTag:kDoVrijemeTag];
        UILabel *linijaLabel = (UILabel *)[cell viewWithTag:kLinijaTag];    
        UILabel *trajanjeVoznjeLabel = (UILabel *)[cell viewWithTag:kTrajanjeTag]; 
    
        /*
        Putovanje *putovanje = [rezultati objectAtIndex:[indexPath section]];
        Linija *linija = [putovanje.linije objectAtIndex:[indexPath row]];;
         */
        
        odKolLabel.text = linija.odlazniKolodvor;
        doKolLabel.text = linija.dolazniKolodvor;
        doVrijemeLabel.text = linija.vrijemeDolaska;
        odVrijemeLabel.text = linija.vrijemeOdlaska;
        linijaLabel.text = linija.nazivLinije;
        trajanjeVoznjeLabel.text = linija.trajanjeVoznje;
    
        linijaLabel.layer.cornerRadius = 4;
    
        UIImageView *oznaka1 = (UIImageView *)[cell viewWithTag:kOznakaTag1];
        UIImageView *oznaka2 = (UIImageView *)[cell viewWithTag:kOznakaTag2];
        UIImageView *oznaka3 = (UIImageView *)[cell viewWithTag:kOznakaTag3];
        UIImageView *oznaka4 = (UIImageView *)[cell viewWithTag:kOznakaTag4];
        UIImageView *oznaka5 = (UIImageView *)[cell viewWithTag:kOznakaTag5];
        UIImageView *oznaka6 = (UIImageView *)[cell viewWithTag:kOznakaTag6];
        UIImageView *oznaka7 = (UIImageView *)[cell viewWithTag:kOznakaTag7];
        UIImageView *oznaka8 = (UIImageView *)[cell viewWithTag:kOznakaTag8];
    
        NSArray *oznakaArray =  [[NSArray alloc] initWithObjects:oznaka1, oznaka2, oznaka3, oznaka4, 
                             oznaka5, oznaka6, oznaka7, oznaka8, nil];  
    
        NSArray *reversedOznake = [[linija.oznake reverseObjectEnumerator] allObjects];    
    
        NSUInteger i = 0;
        for (NSString *oznaka in reversedOznake) {
            UIImage *img = [UIImage imageNamed:oznaka];
            [[oznakaArray objectAtIndex:i] setImage:img];        
            i++;
        }      
    
        for (i = i; i < [oznakaArray count]; i++) 
            [[oznakaArray objectAtIndex:i] setImage:nil];        
    
    }
    else
    {   
        /* showing header = putovanje */
        
        //NSLog(@"showing putovanje");
        
        cell = [tableView dequeueReusableCellWithIdentifier:PutovanjeCellIdentifier];
        
        UILabel *odKolLabel = (UILabel *)[cell viewWithTag:kPutOdKolodvorTag];
        UILabel *doKolLabel = (UILabel *)[cell viewWithTag:kPutDoKolodvorTag];
        UILabel *odVrijemeLabel = (UILabel *)[cell viewWithTag:kPutOdVrijemeTag];
        UILabel *doVrijemeLabel = (UILabel *)[cell viewWithTag:kPutDoVrijemeTag];
        
        UILabel *presjedanjeLabel = (UILabel *)[cell viewWithTag:kPutBrojPresjedanjaTag];    
        UILabel *voznjaLabel = (UILabel *)[cell viewWithTag:kPutTrajanjeVoznjeTag]; 
        UILabel *cekanjeLabel = (UILabel *)[cell viewWithTag:kPutTrajanjeCekanjaTag]; 
        UILabel *putovanjeLabel = (UILabel *)[cell viewWithTag:kPutTrajanjePutovanjaTag]; 
        
        UIImageView *expand = (UIImageView *)[cell viewWithTag:kPutExpandImageTag]; 
        
        Linija *prvaLinija = [[putovanje linije] objectAtIndex:0];
        Linija *zadnjaLinija =  [[putovanje linije] lastObject];
        
        odKolLabel.text = prvaLinija.odlazniKolodvor;
        doKolLabel.text = zadnjaLinija.dolazniKolodvor;
        doVrijemeLabel.text = zadnjaLinija.vrijemeDolaska;
        odVrijemeLabel.text = prvaLinija.vrijemeOdlaska;
        
        presjedanjeLabel.text = [NSString stringWithFormat:@"%d", putovanje.brojPresjedanja];
        voznjaLabel.text = putovanje.trajanjeVoznje;
        cekanjeLabel.text = putovanje.trajanjeCekanja;
        putovanjeLabel.text = putovanje.trajanjePutovanja;
        
        UIImage *img = nil;
        if ([putovanje expanded])
            img = [UIImage imageNamed:@"shrink"];
        else
            img = [UIImage imageNamed:@"expand"];
        
        expand.image = img;
        
    }
    
    return cell;
}       

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"index is %d", buttonIndex);
    if (buttonIndex == kActionChangeIndex)
        [self changeSegment];
    else if (buttonIndex == kActionSwitchIndex)
        [self.navigationController popViewControllerAnimated:YES];

}

@end
