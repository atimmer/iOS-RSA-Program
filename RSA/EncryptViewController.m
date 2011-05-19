//
//  EncryptViewController.m
//  RSA
//
//  Created by Anton Timmermans on 19-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EncryptViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation EncryptViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    toEncryptText.layer.cornerRadius = 5;
    toEncryptText.layer.borderColor = [[UIColor blackColor] CGColor];
    toEncryptText.layer.borderWidth = 1.0;
    
    encryptedText.layer.cornerRadius = 15;
    encryptedText.layer.borderColor = [[UIColor blackColor] CGColor];
    encryptedText.layer.borderWidth = 1.0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
