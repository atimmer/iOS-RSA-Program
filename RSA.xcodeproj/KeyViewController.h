//
//  KeyViewController.h
//  RSA
//
//  Created by Marcel Boersma on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KeyViewController : UITableViewController {
    NSInteger cells;
}

-(IBAction)clickedAddButton:(id)sender;
-(IBAction)clickedEditButton:(id)sender;


@property (nonatomic, retain) IBOutlet UITableViewCell *cell;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *editButton;

@end
