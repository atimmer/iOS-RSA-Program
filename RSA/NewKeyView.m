//
//  NewKeyView.m
//  RSA
//
//  Created by Marcel Boersma on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewKeyView.h"
#import "RSAAppDelegate.h"
#import "RSAKeys.h"
#import <CoreData/CoreData.h>
#import "KeyViewController.h"
#import "NewPrimeView.h"
#import "RSAKeyGenerator.h"


@implementation NewKeyView

@synthesize name, nameTextField, primeA, primeB;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.primeA = [NSNumber numberWithInt:1];
        self.primeB = [NSNumber numberWithInt:1];
        
        
        keyGen = [[RSAKeyGenerator alloc] init];

    }
    
    return self;
}

- (void)dealloc
{
    [nameTextField release];
    [name release];
    
    [primeB release];
    [primeA  release];
    

    [keyGen release];
    
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
    
    
    
    [self.navigationItem setTitle:@"Add RSA Key"];
    [self.navigationItem setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.parentViewController action:@selector(dismissModalViewControllerAnimated:)] autorelease]];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickedSaveButton:)] autorelease]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"NewKeyView::viewWillAppear : reload tableview and check if there is some prime data to be set");
    
    if(pvc)
    {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:[pvc.primeTextField text]];
        [f release];

        
        
        //there is a pvc object, so probably there is a changed prime number
        if([pvc getA])
        {
            NSLog(@"Set prime a as: %i", [myNumber intValue]);
            //the A prime is edited
            self.primeA = [NSNumber numberWithInt:[myNumber intValue]]; 

        }else{
            NSLog(@"Set prime b as: %i", [myNumber intValue]);           
            self.primeB = [NSNumber numberWithInt:[myNumber intValue]];

        }
        
        NSLog(@"Prime a: %i, Prime b : %i", [self.primeA intValue], [self.primeB intValue] );
        
     
        //check if both primes are set, than we can calculate the other numbers like, n, z, public and private key
        if(![self.primeA isEqualToNumber:[NSNumber numberWithInt:1]] || ![self.primeA isEqualToNumber:[NSNumber numberWithInt:1]])
            [keyGen calculateKeyWithPrimeA:[NSDecimalNumber decimalNumberWithString:[self.primeA stringValue]] andPrimeB:[NSDecimalNumber decimalNumberWithString:[self.primeB stringValue]]];
        
        
    }
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Naam";
    }else if(section == 1)
    {
        return @"Priemgetallen";
        
    }else if(section == 2){
        return @"N";
    }else if(section == 3){
        return @"Z";
    }else if(section == 4){
        return @"Public Key";
    }else if(section == 5){
        return @"Private Key";
    }
    
    
    
    return @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSInteger rowsInSection = 0;
    
    if(section == 1)
    {
        rowsInSection = 2;
    }else
    {
        rowsInSection = 1;
    }
    
    return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    switch (indexPath.section) {
        case 0:
            CellIdentifier = @"Name";
            break;
        case 1:
            CellIdentifier = @"Primes";
            break;
        case 2:
            CellIdentifier = @"N";
            break;
        case 3:
            CellIdentifier = @"Z";
            break;
        case 4:
            CellIdentifier = @"Public";
            break;
        case 5:
            CellIdentifier = @"Private";
            break;
        default:
            break;
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    if(indexPath.section == 0)
    {
        NSLog(@"cell for section 0 at indexPath section %i", indexPath.section);
        nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 10, 265, 30)];
        
        nameTextField.text = self.name;
            
        nameTextField.adjustsFontSizeToFitWidth = YES;
        nameTextField.textColor = [UIColor blackColor];
        if ([indexPath row] == 0) {
            nameTextField.placeholder = @"Naam";
            nameTextField.keyboardType = UIKeyboardTypeDefault;
            nameTextField.returnKeyType = UIReturnKeyDone;
        }
       
        [nameTextField addTarget:self action:@selector(didFinishedEditingNameTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        nameTextField.backgroundColor = [UIColor whiteColor];
        nameTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        nameTextField.textAlignment = UITextAlignmentLeft;
        nameTextField.tag = 0;
        //playerTextField.delegate = self;
        
        nameTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
        [nameTextField setEnabled: YES];
        
        [cell addSubview:nameTextField];
    }else if( indexPath.section == 1)
    {
         NSLog(@"cell for section 1 at indexPath section %i", indexPath.section);
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        if(indexPath.row == 0)
        {
            [cell.textLabel setText:[self.primeA stringValue]];
        }else{
            [cell.textLabel setText:[self.primeB stringValue]];
        }
        
    }else if( indexPath.section == 2)
    {
        
        NSLog(@"cell for section 2 at indexPath section %i", indexPath.section);
        //n 
        UITextField *nTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 10, 265, 30)];
        
        if([keyGen.n intValue] != 1)
           nTextField.text = [keyGen.n stringValue];
        
        nTextField.adjustsFontSizeToFitWidth = YES;
        nTextField.textColor = [UIColor blackColor];
        if ([indexPath row] == 0) {
            nTextField.placeholder = @"Kies n om alleen te encrypten";
            nTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            nTextField.returnKeyType = UIReturnKeyDone;
        }
        
        [nTextField addTarget:self action:@selector(didFinishedEditingNTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        nTextField.backgroundColor = [UIColor whiteColor];
        nTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        nTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        nTextField.textAlignment = UITextAlignmentLeft;
        nTextField.tag = 0;
        //playerTextField.delegate = self;
        
        nTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
        [nTextField setEnabled: YES];
        
        [cell addSubview:nTextField];
        [nTextField release];
        
        
        
    }else if( indexPath.section == 3)
    {
         NSLog(@"cell for section 3 at indexPath section %i", indexPath.section);
        //z
        [cell.textLabel setText:[keyGen.z stringValue]];
    }else if( indexPath.section == 4)
    {
        NSLog(@"cell for section 4 at indexPath section %i", indexPath.section);
        //public key
        UITextField *publicKeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 10, 265, 30)];
        
        if([keyGen.publicKey intValue] != 1)
            publicKeyTextField.text = [keyGen.publicKey stringValue];
        
        publicKeyTextField.adjustsFontSizeToFitWidth = YES;
        publicKeyTextField.textColor = [UIColor blackColor];
        if ([indexPath row] == 0) {
            publicKeyTextField.placeholder = @"Kies public om alleen te encrypten";
            publicKeyTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            publicKeyTextField.returnKeyType = UIReturnKeyDefault;
        }
        
        [publicKeyTextField addTarget:self action:@selector(didFinishedEditingPublicKeyTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        publicKeyTextField.backgroundColor = [UIColor whiteColor];
        publicKeyTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        publicKeyTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        publicKeyTextField.textAlignment = UITextAlignmentLeft;
        publicKeyTextField.tag = 0;
        //playerTextField.delegate = self;
        
        publicKeyTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
        [publicKeyTextField setEnabled: YES];
        
        [cell addSubview:publicKeyTextField];
        [publicKeyTextField release];
        
    }else if(indexPath.section == 5)
    {
        NSLog(@"cell for section 5 at indexPath section %i", indexPath.section);
        //private key
        [cell.textLabel setText:[keyGen.privateKey stringValue]];
        
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

-(IBAction)clickedSaveButton:(id)sender
{
    NSLog(@"Clicked saveButton");
    
    
    
    
    RSAKeys *newRSAKey = (RSAKeys*) [NSEntityDescription insertNewObjectForEntityForName:@"RSAKeys" inManagedObjectContext:[(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    if(self.name)
        [newRSAKey setName:[NSString stringWithString:self.name]];
    else
        [newRSAKey setName:[NSString stringWithString:@"Anonimity key"]];
      
        
    [newRSAKey setPrimeA:self.primeA];
    [newRSAKey setPrimeB:self.primeB];
    [newRSAKey setN:[NSNumber numberWithInt:[keyGen.n intValue]]];
    [newRSAKey setZ:[NSNumber numberWithInt:[keyGen.z intValue]]];
    [newRSAKey setPublicKey:[NSNumber numberWithInt:[keyGen.publicKey intValue]]];
    [newRSAKey setPrivateKey:[NSNumber numberWithInt:[keyGen.privateKey intValue]]];
    
    
    [(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
    
    
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    pvc = [[NewPrimeView alloc] initWithNibName:@"NewPrimeView" bundle:nil];
    
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        [pvc setA:YES];
    }else{
        [pvc setA:NO];
    }
    
    [self.navigationController  pushViewController:pvc animated:YES];
    
    
    
}

-(IBAction)didFinishedEditingNameTextField:(id)sender
{
    
    if([sender isKindOfClass:[UITextField class]])
    {
        [self setName:[(UITextField*)sender text]];
        [self resignFirstResponder];
    }
    
   
}


-(IBAction)didFinishedEditingNTextField:(id)sender
{
    if([sender isKindOfClass:[UITextField class]])
    {
        [keyGen setN:[NSDecimalNumber decimalNumberWithString:[(UITextField*)sender text]]];
        [self resignFirstResponder];
    }
}

-(IBAction)didFinishedEditingPublicKeyTextField:(id)sender
{
    if([sender isKindOfClass:[UITextField class]])
    {
        [keyGen setPublicKey:[NSDecimalNumber decimalNumberWithString:[(UITextField*)sender text]]];
        [self resignFirstResponder];
    }
}

@end
