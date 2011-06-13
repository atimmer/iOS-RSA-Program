//
//  EncryptViewController.h
//  RSA
//
//  Created by Anton Timmermans on 19-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EncryptViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate> {

}

@property (nonatomic, retain) IBOutlet NSFetchedResultsController *frc;

@property (nonatomic, retain) IBOutlet UITextField *toEncryptText;
@property (nonatomic, retain) IBOutlet UITextField *encryptedText;


- (void)didEndEditingToEncryptTextField:(id)sender;


@end
