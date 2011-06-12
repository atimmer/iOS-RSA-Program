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
    NSString *decryptedMessage = @"";
    
    for(int i = 0; i < [message length]; i++)
    {
        char aCharFromMessage = [message characterAtIndex:i];
        
        int decryptedChar = (int)pow((double)aCharFromMessage, [self.privateKey doubleValue]) % [self.n intValue];
        
        decryptedMessage = [decryptedMessage stringByAppendingString:[NSString stringWithFormat:@"%i", decryptedChar]];
    }
    
    return decryptedMessage;
}



-(NSString*)encrypteMessage:(NSString*)message
{
    
    NSString *encryptedMessage = @"";
    
    for(int i = 0; i < [message length]; i++)
    {
        char aCharFromMessage = [message characterAtIndex:i];
        
        int encryptedChar = (int)pow((double)aCharFromMessage, [self.publicKey doubleValue]) % [self.n intValue];
        
        encryptedMessage = [encryptedMessage stringByAppendingString:[NSString stringWithFormat:@"%i", encryptedChar]];
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
