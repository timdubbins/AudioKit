//
//  CSDProduct.m
//
//  Created by Aurelius Prochazka on 6/9/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "CSDProduct.h"

@implementation CSDProduct
@synthesize output;

-(id) initWithInputs:(CSDParam *)firstInput,... {
    self = [super init];
    
    if (self) {
        output = [CSDParam paramWithString:[self uniqueName]];
        inputs = [[NSMutableArray alloc] init];
        CSDParam * eachInput;
        va_list argumentList;
        if (firstInput) // The first argument isn't part of the varargs list,
        {                                   // so we'll handle it separately.
            [inputs addObject: firstInput];
            va_start(argumentList, firstInput); // Start scanning for arguments after firstObject.
            while ((eachInput = va_arg(argumentList, id))) // As many times as we can get an argument of type "id"
                [inputs addObject: eachInput]; // that isn't nil, add it to self's contents.
            va_end(argumentList);
        }
    }
    return self; 
}

-(NSString *)convertToCsd
{
    NSString * inputsCombined = [[inputs valueForKey:@"parameterString"] componentsJoinedByString:@", "];
    
    return [NSString stringWithFormat:@"%@ product %@\n",output, inputsCombined];
}

-(NSString *) description {
    return [output parameterString];
}
@end
