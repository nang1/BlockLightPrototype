//
//  SetPiece.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "SetPiece.h"

@implementation SetPiece

@synthesize icon = _icon;
@synthesize piecePosition = _piecePosition;

-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _piecePosition = [[Position alloc] init];
    
    return self;
}

- (id) initWithImage:(NSString *)type {
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _piecePosition = [[Position alloc] init];
    
    if([type isEqualToString:@"Tree"]){
        _icon = [UIImage imageNamed:@"Tree"];
    }
    else if([type isEqualToString:@"Door"]){
        _icon = [UIImage imageNamed:@"Door"];
    }
    else if([type isEqualToString:@"Trash"]){
        _icon = [UIImage imageNamed:@"trash"];
    }
    else { // blank cell
        _icon = [UIImage imageNamed:@"production-settings"];
    }
    
    return self;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"setPieceName"];
    [encoder encodeObject:_uniqueID forKey:@"setPieceID"];
    [encoder encodeObject:UIImagePNGRepresentation(_icon) forKey:@"setPieceIcon"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"setPieceName"];
        self.uniqueID = [decoder decodeObjectForKey:@"setPieceID"];
        self.icon = [UIImage imageWithData:[decoder decodeObjectForKey:@"setPieceIcon"]];
    }
    return self;
}
*/
@end
