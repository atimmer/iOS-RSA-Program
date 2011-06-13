//
//  DecryptViewController.m
//  RSA
//
//  Created by Marcel Boersma(1) on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecryptViewController.h"
#import "RSAKeyGenerator.h"
#import "RSAAppDelegate.h"

@implementation DecryptViewController

@synthesize picker, toDecryptText, decryptedText, frc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Custom initialization of DecryptViewController");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"RSAKeys" inManagedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]]; 
    request.sortDescriptors = [NSArray  arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES] autorelease]];
    request.predicate = [NSPredicate predicateWithFormat:@"PrimeA != %i",1];
    
    
    NSFetchedResultsController *afrc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.frc = afrc;
    
    NSError *error=nil;
    [self.frc performFetch:&error];
    
    [request release];
    [afrc release];
    
    [self.toDecryptText addTarget:self action:@selector(didEndEditingToEncryptTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.picker reloadAllComponents];

    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
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


- (void)didEndEditingToEncryptTextField:(id)sender
{
    NSLog(@"finished editing :)");
    
    if([sender isKindOfClass:[UITextField class]])
    {
        [(UITextField*)sender resignFirstResponder];
        
        if([currentKey  N] != nil && [currentKey PublicKey] != nil){
            
            NSString *textToDecrypt  = [self.toDecryptText text];
            
            RSAKeyGenerator *keyGen = [[RSAKeyGenerator alloc] init];
            [keyGen setN:[NSDecimalNumber decimalNumberWithString:[[currentKey N] stringValue]]];
            [keyGen setPrivateKey:[NSDecimalNumber decimalNumberWithString:[[currentKey PrivateKey] stringValue]]];
            
            NSString *decrypteMessage =  [keyGen decrypteMessage:textToDecrypt];
            
            [self.decryptedText setText:decrypteMessage];
            
            [keyGen release];
            [decrypteMessage release];
            
            
            
        }else{
            NSLog(@"Something went wrong while encrypting");
            [self.decryptedText setText:@"Selecteer een key"];
        }
        
    }
    
}

- (void)pickerView: (UIPickerView *)thePickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    
    NSLog(@"row selected");
    
    currentKey = [self.frc.fetchedObjects objectAtIndex:row];
    
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return [[self.frc fetchedObjects] count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[[self.frc fetchedObjects] objectAtIndex:row] valueForKey:@"Name"];
}

-(void)dealloc
{
 
    [toDecryptText release];
    [decryptedText release];
    [picker release];
    [frc   release];
    [super dealloc];
    
}

@end
