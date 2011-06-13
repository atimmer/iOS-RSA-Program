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

@synthesize cell, addButton, editButton, managedObjectContext, RSAArray, fetchedResultsController;



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        NSLog(@"Initialize KeyViewController");
        RSAArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}



- (void)dealloc
{

    [RSAArray release];
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
    
    NSLog(@"Loading KeyViewController::viewDidLoad");
    
    
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
    NSLog(@"View will appear, reload table data!");
    [self loadKeys];
    [self.tableView reloadData];
    
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
    return [self.fetchedResultsController.fetchedObjects count];
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

   
    NSManagedObject *object = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
   
    
    [(UILabel *)[acell viewWithTag:1] setText:[object valueForKey:@"Name"]];
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
    [aVC setRSAKey:[[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row]];
    
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
    NSManagedObject *rsaKey = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if(self.managedObjectContext == nil)
    {
        self.managedObjectContext = [(RSAAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    
    //delete the record
    [self.managedObjectContext deleteObject:rsaKey];
    
    
    //commit the delete
    NSError *error;
    [self.managedObjectContext save:&error];
    
    
    //reload new keys
    [self loadKeys];
    
    
    //cell to delete
    UITableViewCell *cellToDelete = [tableView cellForRowAtIndexPath:indexPath];
    
    //delete cell
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
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    NSEntityDescription *rsa = [NSEntityDescription entityForName:@"RSAKeys" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:rsa];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = frc;
    
    
    NSError *error = nil;
    
    [self.fetchedResultsController performFetch:&error];
    
  
    if(error)
        NSLog(@"Woops something went wrong...");
    
    
    [request release];
    
    
    
}


            
@end
