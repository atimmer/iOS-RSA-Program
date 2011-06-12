//
//  PrimeView.m
//  RSA
//
//  Created by Marcel Boersma on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimeView.h"
#import "RSAKeys.h"
#import "RSAAppDelegate.h"
#import <CoreData/CoreData.h>

@implementation PrimeView

@synthesize doneButton, primeTextField, pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSLog(@"loading primes");
                
        NSDictionary *primesDic = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PrimesUpTo1000" ofType:@"plist"]] mutableCopy];
        
        
        NSString *primesString= [[primesDic allValues] objectAtIndex:0];
        
        
        primes = [[NSArray alloc] initWithArray:[primesString componentsSeparatedByString:@","]];
    }
    return self;
}

- (void)dealloc
{
   
    [primes release];
    [super dealloc];
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
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.doneButton;
    


    if(a == YES)
        [self.primeTextField setText:[NSString stringWithFormat:@"%@", [rsaKey PrimeA]]]; 
    else
        [self.primeTextField setText:[NSString stringWithFormat:@"%@", [rsaKey PrimeB]]];
  
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [primes count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [primes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.primeTextField setText:[primes objectAtIndex:row]];
}

-(void)setRSAKey:(RSAKeys*)key
{
    NSLog(@"Set RSA Key to edit in primeView");
    
    rsaKey = key;
        
}
-(void)setA:(BOOL)var{
    a = var;
}

-(IBAction)doneButtonClicked:(id)sender
{
    NSLog(@"Done Button");
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[primeTextField text]];
    [f release];
    
    if(a == YES)
    {
        [rsaKey setPrimeA:myNumber]; 
    }else{
        [rsaKey setPrimeB:myNumber];
    }
    
    [(RSAAppDelegate*)[[UIApplication sharedApplication]delegate] saveContext];
    
    
    [myNumber release];
   
    
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

@end
