//
//  NewPrimeView.h
//  RSA
//
//  Created by Marcel Boersma on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAKeys.h"

@interface NewPrimeView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSArray *primes;
    BOOL a;
    
}

-(IBAction)doneButtonClicked:(id)sender;
-(void)setA:(BOOL)var;
-(BOOL)getA;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UITextField *primeTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@end
