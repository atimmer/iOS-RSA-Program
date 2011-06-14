//
//  RSAKeyGenerator.m
//  RSA
//
//  Created by Marcel Boersma on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RSAKeyGenerator.h"
#import "math.h"

@implementation RSAKeyGenerator

@synthesize primeA, primeB, n, z,  publicKey, privateKey;

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Init RSAKeyGenerator");

        
        // Initialization code here.
        self.primeA = [NSDecimalNumber decimalNumberWithString:@"1"];
        self.primeB = [NSDecimalNumber decimalNumberWithString:@"1"];
        
        self.n = [NSDecimalNumber decimalNumberWithString:@"1"];
        self.z = [NSDecimalNumber decimalNumberWithString:@"2"];
        
        self.publicKey = [NSDecimalNumber decimalNumberWithString:@"1"];
        self.privateKey = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
    
    return self;
}

-(void)calculateKeyWithPrimeA:(NSDecimalNumber*)aPrime andPrimeB:(NSDecimalNumber*)bPrime
{
    NSLog(@"Do some calculations!!!!!");

    self.primeA = aPrime;
    self.primeB = bPrime;
    
    //set public key
    self.n = [aPrime decimalNumberByMultiplyingBy:bPrime];
    
    //calculate z
    self.z = [[aPrime decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]] decimalNumberByMultiplyingBy:[bPrime decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]]];


    //calculate e such that gcd(e,z) = 1
    
    for(int i = 0; i < [self.n intValue]; i++)
    {
        if([self GCDWithIntA:i andIntB:[self.z intValue]] == 1)
        {
          
            self.publicKey = [NSDecimalNumber decimalNumberWithString:[[NSNumber numberWithInt:i] stringValue]];
        }
    }
    
       
    for(int i = 2; i < [self.n intValue]; i++)
    {
        int ed = [[self.publicKey decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[[NSNumber numberWithInt:i] stringValue]]] intValue];
        
        if([self.z intValue] != 0){
            if( (ed % [self.z intValue]) == 1)
            {
                //found the number i such that e*i mod z = 1 (the inverse of e)
                self.privateKey = [NSDecimalNumber decimalNumberWithString:[[NSNumber numberWithInt:i] stringValue]];
            }
        }
    }
    

}

-(int) GCDWithIntA:(int)a andIntB:(int) b
{
    if (b==0) return a;
    return [self GCDWithIntA:b andIntB:a%b];

}


-(NSString*)decrypteMessage:(NSString*)message
{
#warning CAN'T CALCULATE NUMBERS OF THAT SIZE (SO RSA WON'T WORK!!!)
    NSString *decryptedMessage = @"";
    
     NSArray *chars = [message componentsSeparatedByString:@" "];
    
    for(int i = 0; i < [chars count]; i++)
    {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:[chars objectAtIndex:i]];
        [f release];
        
        int charToDecrypt = [myNumber intValue];
        
        NSDecimalNumber *bigNumber = [[[NSDecimalNumber alloc] initWithInteger:charToDecrypt] autorelease];
        
        NSDecimalNumber *powOfBigNum = [[bigNumber decimalNumberByRaisingToPower:[self.privateKey intValue]] autorelease];
        int decryptedChar = [powOfBigNum integerValue] % [self.n integerValue];
        NSLog(@"self.n %i self.privateKey %i", [self.n intValue], [self.privateKey intValue]);
        NSLog(@"Char to decrypt %i and decrypted char %i", [myNumber intValue], decryptedChar);

        
        decryptedMessage = [decryptedMessage stringByAppendingString:[NSString stringWithFormat:@"%c ", decryptedChar]];
    }
    
    return decryptedMessage;
}



-(NSString*)encrypteMessage:(NSString*)message
{
 #warning CAN'T CALCULATE NUMBERS OF THAT SIZE (SO RSA WON'T WORK!!!)   
    NSString *encryptedMessage = @"";
        
    for(int i = 0; i < [message length]; i++)
    {
        char aCharFromMessage = [message characterAtIndex:i];
        
        
        NSDecimalNumber *bigNumber = [[[NSDecimalNumber alloc] initWithInteger:aCharFromMessage] autorelease];
        
        NSDecimalNumber *powOfBigNum = [[bigNumber decimalNumberByRaisingToPower:[self.publicKey intValue]] autorelease];
        int encryptedChar = [powOfBigNum integerValue] % [self.n integerValue];

        
        encryptedMessage = [encryptedMessage stringByAppendingString:[NSString stringWithFormat:@"%i ", encryptedChar]];
    }
    
    return encryptedMessage;
}


-(void)dealloc
{
    [primeA release];
    [primeB release];
    [n release];
    [z release];
    [publicKey release];
    [privateKey release];
    [super dealloc];
}

@end
