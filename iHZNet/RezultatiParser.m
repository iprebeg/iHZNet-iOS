//
//  RezultatiParser.m
//  iHZNet
//
//  Created by Ivor Prebeg on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RezultatiParser.h"
#import "Putovanje.h"
#import "Linija.h"

static UIViewController *controller = nil;

@implementation RezultatiParser


@synthesize currentPutovanje;
@synthesize currentLinija;
@synthesize currentKolodvor;
@synthesize currentStajaliste;
@synthesize currentProlaziste;

@synthesize currentOznake;
@synthesize currentLinije;
@synthesize currentStajalista;

@synthesize currentProperty;

@synthesize kolodvori;
@synthesize prolazista;

@synthesize raspored;

-(BOOL)checkForSubstring:(NSString*)substring inString:(NSString*)string
{
	
    if ([string rangeOfString:substring].location == NSNotFound)
        return NO;
	
	return YES;
}

- (NSMutableArray*)getKolodvori
{
	return kolodvori;
}

- (Raspored*)getRaspored
{
	return raspored;
}

- (NSMutableArray*)getLiveInfo
{
    return prolazista;
}

//////////////////// XML ////////////////////////
- (BOOL)parseXML:(NSData *)xml
{   
    NSString *xmlRes = [[NSString alloc]initWithData:xml encoding:NSUTF8StringEncoding];	

    if ([self checkForSubstring:@"<h1>Software error:</h1>" inString:xmlRes]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"UPOZORENJE!" message:@"Pogreška pri procesiranju zahtjeva na poslužitelju!" delegate:controller cancelButtonTitle:@"OK!" otherButtonTitles:@"Pokušajte ponovno!",nil];	
        
        [alert show];
        
        return false;
    }

#ifdef DEBUG
    NSLog(@"########################################## XML ################");
    NSLog(xmlRes);
#endif
    

    
    
    NSXMLParser *xmlParser =  [[NSXMLParser alloc] initWithData:xml];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    
    return TRUE;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
    if ( [elementName isEqualToString:@"liveInfo"]) {
        if (!prolazista)
            prolazista = [[NSMutableArray alloc] init];
        return;
    }
    
    /* elementi Prolazista */
    
    if ( [elementName isEqualToString:@"prolaziste"] ) {
        currentProlaziste = [[Prolaziste alloc] init];
        return;
    }
    
    if ( 
        [elementName isEqualToString:@"nazivProlazista"             ] || 
        [elementName isEqualToString:@"vrijemeDolaskaProlaziste"    ] ||
        [elementName isEqualToString:@"vrijemeOdlaskaProlaziste"    ] ||
        [elementName isEqualToString:@"kasnjenjeOdlaska"            ] ||
        [elementName isEqualToString:@"kasnjenjeDolaska"            ]
        ) 
    {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }

    /* kolodvori */
    
    if ( [elementName isEqualToString:@"listaKolodvora"]) {
        if (!kolodvori)
            kolodvori = [[NSMutableArray alloc] init];
        return;
    }

    /* elementi Kolodvora */

    if ( [elementName isEqualToString:@"kolodvor"] ) {
        currentKolodvor = [[Kolodvor alloc] init];
        return;
    }
    
    if ( 
        [elementName isEqualToString:@"idKolodvora"       ] || 
        [elementName isEqualToString:@"nazivKolodvora"    ] 
        ) 
    {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }
    
    /* raspored */
    
    if ( [elementName isEqualToString:@"raspored"]) {
        raspored = [[Raspored alloc] init];
        if (raspored.putovanja == nil)
            raspored.putovanja = [[NSMutableArray alloc] init];
        return;
    }
    
    /* elementi putovanje */
    
    if ( [elementName isEqualToString:@"putovanje"] ) {
        currentPutovanje = [[Putovanje alloc] init];
        currentPutovanje.expanded = NO;
        return;
    }
        
    if ( 
        [elementName isEqualToString:@"waitpoll"               ] || 
        [elementName isEqualToString:@"izravno"                ] || 
        [elementName isEqualToString:@"brojPresjedanja"        ] ||
        [elementName isEqualToString:@"ukupnoTrajanjeVoznje"   ] ||
        [elementName isEqualToString:@"ukupnoTrajanjeCekanja"  ] ||
        [elementName isEqualToString:@"ukupnoTrajanjePutovanja"] 
        ) 
    {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }
    
    if ( [elementName isEqualToString:@"linije"]) {
        currentLinije = [[NSMutableArray alloc] init];
        return;
    }
    
    /* elementi linija */

    if ( [elementName isEqualToString:@"linija"] ) {
        currentLinija = [[Linija alloc] init];
    }
        
    if ( 
        [elementName isEqualToString:@"nazivLinije"    ] || 
        [elementName isEqualToString:@"odlazniKolodvor"] ||
        [elementName isEqualToString:@"dolazniKolodvor"] ||
        [elementName isEqualToString:@"vrijemeOdlaska" ] ||
        [elementName isEqualToString:@"vrijemeDolaska" ] ||
        [elementName isEqualToString:@"trajanjeVoznje" ] 
        ) 
    {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }
    
    ///
    if ( [elementName isEqualToString:@"listaStajalista"]) {
        currentStajalista = [[NSMutableArray alloc] init];
        return;
    }
    
    /* elementi stajalista */
    
    if ( [elementName isEqualToString:@"stajaliste"] ) {
        currentStajaliste = [[Stajaliste alloc] init];
    }
    
    if ( 
        [elementName isEqualToString:@"nazivStajalista"          ] || 
        [elementName isEqualToString:@"vrijemeOdlaskaStajaliste" ] ||
        [elementName isEqualToString:@"vrijemeDolaskaStajaliste" ]
       ) 
    {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }
    

    ///

    /* oznake */
    
    if ( [elementName isEqualToString:@"oznake"] ) {
        currentOznake = [[NSMutableArray alloc] init];
        return;
    }
    
    if ( [elementName isEqualToString:@"oznaka"] ) {
        currentProperty = [[NSMutableString alloc] init];
        return;
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"liveInfo"]) {
        return;
    }

    if ( [elementName isEqualToString:@"raspored"]) {
        return;
    }
    
    /* elementi Prolazista */
    
    if ( [elementName isEqualToString:@"prolaziste"] ) {
        [prolazista addObject:currentProlaziste];
        return;
    }
    
    if ( [elementName isEqualToString:@"nazivProlazista"]) 
    {
        [currentProlaziste setNaziv:currentProperty];
        return;
    }

    if ( [elementName isEqualToString:@"vrijemeDolaskaProlaziste"]) 
    {
        [currentProlaziste setVrijemeDolaska:currentProperty];
        return;
    }

    if ( [elementName isEqualToString:@"vrijemeOdlaskaProlaziste"]) 
    {
        [currentProlaziste setVrijemeOdlaska:currentProperty];
        return;
    }
    
    
    if ( [elementName isEqualToString:@"kasnjenjeOdlaska"]) 
    {
        [currentProlaziste setKasnjenjeOdlaska:currentProperty];
        return;
    }
    
    
    if ( [elementName isEqualToString:@"kasnjenjeDolaska"]) 
    {
        [currentProlaziste setKasnjenjeDolaska:currentProperty];
        return;
    }
    
    /* listaKolodvora = kolodvori */
    if ( [elementName isEqualToString:@"listaKolodvora"]) {
        return;
    }
    
    /* kolodvor */
    
    if ( [elementName isEqualToString:@"kolodvor"] ) {
        [kolodvori addObject: currentKolodvor];
        return;
    }
    
    if ( [elementName isEqualToString:@"idKolodvora"]) 
    {
        [currentKolodvor setIdKolodvora:[currentProperty integerValue]];
        return;
    }

    if ([elementName isEqualToString:@"nazivKolodvora"]) 
    {
        [currentKolodvor setNaziv:currentProperty];
        return;
    }
    
    /* raspored = rezultati */
    
    if ( [elementName isEqualToString:@"raspored"]) {
        return;
    }    
    
    /* elementi putovanje */
    
    if ( [elementName isEqualToString:@"putovanje"] ) {
        [raspored.putovanja addObject:currentPutovanje];
        return;
    }
    
    if ( [elementName isEqualToString:@"izravno"] ) {
        if ([currentProperty isEqualToString:@"false"])
            [currentPutovanje setIzravno:false];
        else
            [currentPutovanje setIzravno:true];
        
        return;
    }

    if ( [elementName isEqualToString:@"waitpoll"] ) {
        if ([currentProperty isEqualToString:@"false"])
            [raspored setWaitpoll:false];
        else
            [raspored setWaitpoll:true];
        
        return;
    }
    
    if ( [elementName isEqualToString:@"brojPresjedanja"] ) {
        [currentPutovanje setBrojPresjedanja:[currentProperty integerValue]];
        return;
    }
    
    if ( [elementName isEqualToString:@"ukupnoTrajanjeVoznje"] ) {
        [currentPutovanje setTrajanjeVoznje:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"ukupnoTrajanjeCekanja"] ) {
        [currentPutovanje setTrajanjeCekanja:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"ukupnoTrajanjePutovanja"] ) {
        [currentPutovanje setTrajanjePutovanja:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"linije"] ) {
        [currentPutovanje setLinije:currentLinije];
        return;
    }
    
    /* elementi linija */
    
    if ( [elementName isEqualToString:@"linija"] ) {
        [currentLinije addObject:currentLinija];
        return;
    }
    
    if ( [elementName isEqualToString:@"listaStajalista"] ) {
        [currentLinija setStajalista:currentStajalista];
        return;
    }
    
    if ( [elementName isEqualToString:@"stajaliste"] ) {
        [currentStajalista addObject:currentStajaliste];
        return;
    }
    
    if ( [elementName isEqualToString:@"nazivStajalista"] ) {
        [currentStajaliste setNazivStajalista:currentProperty];
        return;
    }

    if ( [elementName isEqualToString:@"vrijemeDolaskaStajaliste"] ) {
        [currentStajaliste setVrijemeDolaskaStajaliste:currentProperty];
        return;
    }

    if ( [elementName isEqualToString:@"vrijemeOdlaskaStajaliste"] ) {
        [currentStajaliste setVrijemeOdlaskaStajaliste:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"nazivLinije"] ) {
        [currentLinija setNazivLinije:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"odlazniKolodvor"] ) {
        [currentLinija setOdlazniKolodvor:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"dolazniKolodvor"] ) {
        [currentLinija setDolazniKolodvor:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"vrijemeOdlaska"] ) {
        [currentLinija setVrijemeOdlaska:currentProperty];
        return;
    }
    
    if ( [elementName isEqualToString:@"vrijemeDolaska"] ) {
        [currentLinija setVrijemeDolaska:currentProperty];
        return;
    }

    if ( [elementName isEqualToString:@"trajanjeVoznje"] ) {
        [currentLinija setTrajanjeVoznje:currentProperty];
        return;
    }

        
    /* oznake */
    
    if ( [elementName isEqualToString:@"oznake"] ) {
        [currentLinija setOznake:currentOznake];
        return;
    }
    
    if ( [elementName isEqualToString:@"oznaka"] ) {        
        [currentOznake addObject:currentProperty];
        return;
    }    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentProperty) {
        currentProperty = [currentProperty stringByAppendingString:string];
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    
    NSString *error = [NSString stringWithFormat:@"Error %i, Description: %@, Line: %i, Column: %i", 
                    [parseError code],
                    [[parser parserError] localizedDescription], [parser lineNumber],
                    [parser columnNumber]];
    
    NSLog(@"%@", error);

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UPOZORENJE!" message:@"Pogreška pri procesiranju odgovora!" delegate:controller cancelButtonTitle:@"OK!" otherButtonTitles:@"Pokušajte ponovno!",nil];	
    
    [alert show];
    
}

@end
