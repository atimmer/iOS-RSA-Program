//
//  NewPrimeView.m
//  RSA
//
//  Created by Marcel Boersma on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewPrimeView.h"
#import "RSAKeys.h"
#import "RSAAppDelegate.h"
#import <CoreData/CoreData.h>

@implementation NewPrimeView

@synthesize doneButton, primeTextField, pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSLog(@"loading primes for new prime");
        
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
    
    [self.primeTextField setText:@"1"]; 

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


-(void)setA:(BOOL)var{
    a = var;
}

-(BOOL)getA
{
    return a;
}

-(IBAction)doneButtonClicked:(id)sender
{
    NSLog(@"Done Button");
    
        
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

@end
