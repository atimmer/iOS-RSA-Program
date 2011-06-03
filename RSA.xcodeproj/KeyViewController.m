//
//  KeyViewController.m
//  RSA
//
//  Created by Marcel Boersma on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import "DetailedKeyView.h"
#import "NewKeyNavigationView.h"
#import "RSAKeys.h"
#import "RSAAppDelegate.h"

@implementation KeyViewController

@synthesize cell, addButton, editButton, managedObjectContext, RSAArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)dealloc
{
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
    
    RSAArray = [[NSMutableArray alloc] init];
    
    
    //Hide the toolbar
    self.navigationController.toolbarHidden = YES;
    
    //hide the prompt message
    self.navigationItem.prompt = nil;
    
    //Set the title of the tableview
    self.navigationItem.title = @"RSA Keys";
    
    //set the addbutton
    self.navigationItem.rightBarButtonItem = self.addButton;
    //self.myNavigationItem.leftBarButtonItem = self.editButton;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;

    [self.editButton setAction:@selector(clickedEditButton:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadKeys) name:@"newKeys" object:nil];
    
    [self loadKeys];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [RSAArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"KeyCell";
    
    UITableViewCell *acell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (acell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"KeyTableViewCell" owner:self options:nil];
        acell = self.cell;
       
    }

    UISwipeGestureRecognizer *leftslide = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clickedEditButton:)];
    [leftslide setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [acell setGestureRecognizers:[NSArray arrayWithObjects: leftslide, nil]];

    
   
    
    [(UILabel *)[acell viewWithTag:1] setText:[[RSAArray objectAtIndex:indexPath.row] Name]];
    [(UILabel *)[acell viewWithTag:2] setText:@"RSA Key"];
    
    // Configure the cell...
    
   
    
    return acell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    DetailedKeyView *aVC = [[DetailedKeyView alloc] initWithNibName:@"DetailedKeyView" bundle:nil];
    
    [self.navigationController pushViewController:aVC animated:YES];
    
    [aVC release];
    
    
}

-(IBAction)clickedAddButton:(id)sender
{
    NSLog(@"Add button clicked");
    
    NewKeyNavigationView *newKeyView = [[NewKeyNavigationView alloc] initWithNibName:@"NewKeyView" bundle:nil];
    
    [newKeyView.navigationItem.rightBarButtonItem setTarget:self];
    [newKeyView.navigationItem.rightBarButtonItem setAction:@selector(clickedSaveButton:)];
 
    [self.navigationController presentModalViewController:newKeyView animated:YES];
    
    
    [newKeyView release];
}

-(IBAction)clickedEditButton:(id)sender
{
    CGPoint swipeLocation = [(UISwipeGestureRecognizer*)sender locationInView:self.tableView];
    NSIndexPath *swipeIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    UITableViewCell *scell = [self.tableView cellForRowAtIndexPath:swipeIndexPath];
    
    if(![scell isEditing])
        [scell   setEditing:YES animated:YES];
    
    
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell to delete
    RSAKeys *rsaKey = [self.RSAArray objectAtIndex:indexPath.row];
    
    if(self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    [self.managedObjectContext deleteObject:rsaKey];
    
    [self.RSAArray removeObject:rsaKey];
    
    
    UITableViewCell *cellToDelete = [tableView cellForRowAtIndexPath:indexPath];
    
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    
    [cellToDelete setEditing:NO animated:YES];
    
    NSLog(@"Cell succesfully deleted");
  
}

-(void)loadKeys
{
    NSLog(@"load keys into array");
    
    if(self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *rsa = [NSEntityDescription entityForName:@"RSAKeys" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:rsa];
    
    NSError *error = nil;
    
    NSMutableArray *results = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if(results)
    {
        
        RSAArray = [[NSMutableArray alloc] initWithArray:results ];
        [self.tableView reloadData];
        
    }
    
    [results release];
    [request release];
    
    
    
}


            
@end
