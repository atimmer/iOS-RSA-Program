//
//  PrimeView.h
//  RSA
//
//  Created by Marcel Boersma on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAKeys.h"

@interface PrimeView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSArray *primes;
    RSAKeys *rsaKey;
    
    BOOL a;
    
}

-(IBAction)doneButtonClicked:(id)sender;
-(void)setRSAKey:(RSAKeys*)key;
-(void)setA:(BOOL)var;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UITextField *primeTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@end
