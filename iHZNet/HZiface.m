//
//  HZiface.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HZiface.h"
#import "RezultatiParser.h"
#import "Putovanje.h"
#import "Indicators.h"

/* for commit */
static HZiface *shared = nil;

@implementation HZiface

@synthesize loaded;
@synthesize receivedData;
@synthesize kolodvori;
@synthesize odlazniKolodvor;
@synthesize dolazniKolodvor;
@synthesize dv;
@synthesize vrijeme;

+ (BOOL) isLoaded
{
    if (shared == nil)
        return false;
    else
        return true;
}

+ (HZiface *) sharedHZiface
{
	if (!shared || shared == nil)
	{
		shared = [[HZiface alloc] init];
        shared.loaded = NO;
        shared.dv = @"D";
        shared.vrijeme = [NSDate date];
        
        [shared loadKolodvori];
      
        /*
        Kolodvor *odlazni = [[Kolodvor alloc] init];
        Kolodvor *dolazni = [[Kolodvor alloc] init];
        
        odlazni.idKolodvora = 386;
        odlazni.naziv = @"OS";
        
        dolazni.idKolodvora = 517;
        dolazni.naziv = @"ST";
        
        shared.odlazniKolodvor = odlazni;
        shared.dolazniKolodvor = dolazni;
        
         */
	}
    
    /* check if user entered date that is earlier than today */
    if ([shared.vrijeme compare:[NSDate date]] == NSOrderedAscending) {
        shared.vrijeme = [NSDate date];
    }     
    
	return shared;
}    

-(void)loadKolodvori
{    
    
    NSString *req = [NSString stringWithString:kURLKolodvori];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:req]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:20.0];	
	NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    
	if (con) {
        receivedData = [NSMutableData data];
		NSLog(@"created connection");
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
    
    [[Indicators sharedIndicators] stop];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UPOZORENJE!" message:@"Neuspjelo spajanje na poslužitelj!" delegate:self cancelButtonTitle:@"Pokušajte ponovno!" otherButtonTitles:nil];
    [alert show];
	
    NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey] );
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex == 0)
    {        
        [self loadKolodvori];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	//NSLog(@"Succeded loading! loaded %d bytes", [receivedData length]);
    
    RezultatiParser *rezParser = [[RezultatiParser alloc] init];
    
    [rezParser parseXML:receivedData];
    
    shared.kolodvori = [rezParser getKolodvori];
    
    Kolodvor *odlazni = [[Kolodvor alloc] init];
    Kolodvor *dolazni = [[Kolodvor alloc] init];

    odlazni.naziv = @"<Odlazni kolodvor>";
    odlazni.idKolodvora = 0;
    
    dolazni.naziv = @"<Dolazni kolodvor>";
    dolazni.idKolodvora = 0;
    
    for (Kolodvor *kolodvor in shared.kolodvori)
    {
        if ([[[kolodvor naziv] uppercaseString] isEqualToString:[@"Zagreb Gl. kol." uppercaseString]]) 
        {
            odlazni.naziv = kolodvor.naziv;
            odlazni.idKolodvora = kolodvor.idKolodvora;
        }
        
        if ([[[kolodvor naziv] uppercaseString] isEqualToString:[@"Split" uppercaseString]]) 
        {
            dolazni.naziv = kolodvor.naziv;
            dolazni.idKolodvora = kolodvor.idKolodvora;
        }
    }
    
    shared.odlazniKolodvor = odlazni;
    shared.dolazniKolodvor = dolazni;
    
    [[Indicators sharedIndicators]stop];
    
    shared.loaded = YES;
}

@end
