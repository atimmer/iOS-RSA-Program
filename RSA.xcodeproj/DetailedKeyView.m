//
//  DetailedKeyView.m
//  RSA
//
//  Created by Marcel Boersma on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedKeyView.h"
#import "PrimeView.h"
#import "RSAKeys.h"

@implementation DetailedKeyView

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
    
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@", [rsaKey Name]]];
    
  
    

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
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //reload tableview
    [self.tableView reloadData];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Priemgetallen";
        
    }else if(section == 1){
        return @"N/Z";
    }else if(section == 2){
        return @"Keys";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
   
    
    // Configure the cell...
    
    switch (indexPath.section) {
        case 0 :
            if(indexPath.row==0)
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey PrimeA]]];
            else
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey PrimeB]]];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                 
            break;
        case 1 :
            if(indexPath.row==0)
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey N]]];
            else
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey Z]]];

            break;
        case 2 :
            if(indexPath.row==0)
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey PrivateKey]]];
            else
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[rsaKey PublicKey]]];

            break;
            
        default:
            break;
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
    
    if([indexPath section] == 0)
    {
        PrimeView *pv = [[PrimeView alloc] initWithNibName:@"PrimeView" bundle:nil];
        if([indexPath row] == 0)
        {
            [pv setA:YES];
        }
        
        if(rsaKey)
            [pv setRSAKey:rsaKey];
        
        [self.navigationController  pushViewController:pv animated:YES];
        
        [pv release];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)setRSAKey:(RSAKeys*)key
{
    NSLog(@"Set RSA Key to edit");
    
    rsaKey = key;
    
    
}


@end
