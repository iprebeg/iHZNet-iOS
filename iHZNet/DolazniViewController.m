    //
//  OdredisniViewController.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DolazniViewController.h"
#import "HZiface.h"
#import "Kolodvor.h"

@implementation DolazniViewController

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HZiface *iface = [HZiface sharedHZiface];
    
    NSUInteger row = indexPath.row;
	Kolodvor *kolodvor = nil;
    
	if ([savedSearchTerm length] != 0) {
        kolodvor = [kolodvoriFiltered objectAtIndex:row];
    }
	else { 
        kolodvor = [kolodvori objectAtIndex:row];
    }
    
    if (iface.odlazniKolodvor.idKolodvora == kolodvor.idKolodvora)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"UPOZORENJE!" message:@"Odabrali ste isti kolodvor kao polazni i odredišni!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alert show];
        return;
    }

    iface.dolazniKolodvor.idKolodvora = kolodvor.idKolodvora;
    iface.dolazniKolodvor.naziv = kolodvor.naziv;
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
