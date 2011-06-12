//
//  KeyViewController.h
//  RSA
//
//  Created by Marcel Boersma on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RSAKeys.h"

@interface KeyViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchResultsController;
    NSMutableArray *RSAArray;
    NSManagedObjectContext *managedObjectContext;
}

-(IBAction)clickedAddButton:(id)sender;
-(IBAction)clickedEditButton:(id)sender;

-(void)loadKeys;


@property (nonatomic, retain) IBOutlet UITableViewCell *cell;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *editButton;

@property (nonatomic, retain) IBOutlet NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet NSMutableArray *RSAArray;
@property (retain) NSFetchedResultsController *fetchedResultsController;

@end
