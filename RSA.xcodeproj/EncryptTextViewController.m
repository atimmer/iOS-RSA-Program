//
//  EncryptTextViewController.m
//  RSA
//
//  Created by Marcel Boersma on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EncryptTextViewController.h"
#import <CoreData/CoreData.h>
#import "RSAAppDelegate.h"
#import "RSAKeyGenerator.h"
#import "RSAKeys.h"

@implementation EncryptTextViewController
@synthesize frc, toEncryptText,encryptedText, picker ;

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Custom initialization of EncryptViewController");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"RSAKeys" inManagedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]]; 
    request.sortDescriptors = [NSArray  arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES] autorelease]];
    request.predicate = [NSPredicate predicateWithFormat:@"PrimeA = %i",1];
    
    
    NSFetchedResultsController *afrc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.frc = afrc;
    
    NSError *error=nil;
    [self.frc performFetch:&error];
    
    [request release];
    [afrc release];
    
    [self.toEncryptText addTarget:self action:@selector(didEndEditingToEncryptTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.picker reloadAllComponents];}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    return [[self.frc fetchedObjects] count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[[self.frc fetchedObjects] objectAtIndex:row] valueForKey:@"Name"];
}

- (void)didEndEditingToEncryptTextField:(id)sender
{
    NSLog(@"finished editing :)");
    
    if([sender isKindOfClass:[UITextField class]])
    {
         [(UITextField*)sender resignFirstResponder];
        
        if([currentKey  N] != nil && [currentKey PublicKey] != nil){
            NSString *textToEncrypt  = [self.toEncryptText text];
            
            RSAKeyGenerator *keyGen = [[RSAKeyGenerator alloc] init];
            [keyGen setN:[NSDecimalNumber decimalNumberWithString:[[currentKey N] stringValue]]];
            [keyGen setPublicKey:[NSDecimalNumber decimalNumberWithString:[[currentKey PublicKey] stringValue]]];
            
            NSString *encryptedMessage =  [keyGen encrypteMessage:textToEncrypt];
            
            [self.encryptedText setText:encryptedMessage];
            
            [keyGen release];
            
            
            
        }else{
            NSLog(@"Something went wrong while encrypting");
        }

    }
    
}
     
- (void)pickerView: (UIPickerView *)thePickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    
    NSLog(@"row selected");
    
    currentKey = [self.frc.fetchedObjects objectAtIndex:row];

   
    
}

-(void)dealloc
{
    [picker release];
    [encryptedText release];
    [toEncryptText release];
    [frc dealloc];
    
    [super dealloc];
    
}

@end
