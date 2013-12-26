//
//  LinijaViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 12/28/11.
//  Copyright (c) 2011 Sedam IT. All rights reserved.
//

#import "LinijaViewController.h"
#import "Linija.h"
#import "Stajaliste.h"
#import "LiveInfoViewController.h"

@implementation LinijaViewController

@synthesize stajalista;
@synthesize stajalistaTable;
@synthesize linija;

static NSString *FavoritCellIdentifier = @"StajalisteCellIdentifier";

- (void)configureWithLinija:(Linija*)theLinija
{
    linija = theLinija;
    stajalista = [linija stajalista];
    self.title = [linija nazivLinije];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    //NSLog(@"ima %d", [stajalista count]);
    return [stajalista count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return kStajalisteTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:FavoritCellIdentifier];
    
    Stajaliste *stajaliste = [stajalista objectAtIndex:row];

    UILabel *nazivLabel     = (UILabel *)[cell viewWithTag:kNazivStajalistaTag];
    UILabel *doVrijemeLabel = (UILabel *)[cell viewWithTag:kVrijemeDolaskaStajalisteTag];
    UILabel *odVrijemeLabel = (UILabel *)[cell viewWithTag:kVrijemeOdlaskaStajalisteTag];
    
    nazivLabel.text = [stajaliste nazivStajalista];
    doVrijemeLabel.text = [stajaliste vrijemeDolaskaStajaliste];
    odVrijemeLabel.text = [stajaliste vrijemeOdlaskaStajaliste];
    
    return cell;
}       

- (IBAction)liveInfoButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"liveinfoSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"liveinfoSegue"])
    {
        LiveInfoViewController *liveInfoVC = (LiveInfoViewController *)segue.destinationViewController;
        if (linija != nil && liveInfoVC != nil)
        {
            [liveInfoVC configureWithLinija:linija];
        }
    }

}

@end
