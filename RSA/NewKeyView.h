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
#import "NewPrimeView.h"
#import "RSAKeyGenerator.h"

@interface NewKeyView : UITableViewController {
    NewPrimeView *pvc;
    RSAKeyGenerator *keyGen;
    
}

-(IBAction)clickedSaveButton:(id)sender;
-(IBAction)didFinishedEditingNameTextField:(id)sender;
-(IBAction)didFinishedEditingNTextField:(id)sender;
-(IBAction)didFinishedEditingPublicKeyTextField:(id)sender;

@property (nonatomic, retain) IBOutlet NSString *name;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;

@property (nonatomic, retain) IBOutlet NSNumber *primeA;
@property (nonatomic, retain) IBOutlet NSNumber *primeB;


@end
