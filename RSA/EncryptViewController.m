//
//  EncryptViewController.m
//  RSA
//
//  Created by Anton Timmermans on 19-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EncryptViewController.h"
#import <CoreData/CoreData.h>
#import "RSAAppDelegate.h"

@implementation EncryptViewController

@synthesize frc, toEncryptText, encryptedText, scrollView;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        NSLog(@"Custom initialization of EncryptViewController");
    }
    
    return self;
}

-(id)init
{
    
    self = [super init];
    if(self)
    {
        NSLog(@"Custom initialization of EncryptViewController");
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)dealloc
{
    [self.frc release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"Custom initialization of EncryptViewController");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"RSAKeys" inManagedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]]; 
    request.sortDescriptors = [NSArray  arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"Name" ascending:YES] autorelease]];
    request.predicate = [NSPredicate predicateWithFormat:@"PrivateKey = %i",1];
    
    
    NSFetchedResultsController *afrc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:@"RSAcache"];
    
    self.frc = afrc;
    
    NSError *error=nil;
    [self.frc performFetch:&error];
    
    [request release];
    [afrc release];
    
    [self.toEncryptText setText:@"Tekst om de encrypten hier typen"];
    [self.toEncryptText setReturnKeyType:UIReturnKeyDone];
    [self.toEncryptText addTarget:self action:@selector(didEndEditingToEncryptTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];

    [self.toEncryptText retain];
    [self.encryptedText setText:@"Hier staat de geëncrypte tekst"];

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

- (void)didEndEditingToEncryptTextField:(id)sender
{
    NSLog(@"finished editing :)");
    
    if([sender isKindOfClass:[UITextField class]])
    {
       // [(UITextField*)sender resignFirstResponder];
    }
    
}

@end
