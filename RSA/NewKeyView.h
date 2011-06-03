//
//  NewKeyView.h
//  RSA
//
//  Created by Marcel Boersma on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KeyViewController.h"

@interface NewKeyView : UITableViewController {
    NSManagedObjectContext *managedObjectContext;
}

-(IBAction)clickedSaveButton:(id)sender;


@property (nonatomic, retain) IBOutlet NSManagedObjectContext *managedObjectContext;

@end
