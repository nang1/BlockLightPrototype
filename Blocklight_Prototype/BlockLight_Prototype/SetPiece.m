//
//  SetPiece.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "SetPiece.h"

@implementation SetPiece

@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize icon = _icon;
@synthesize piecePosition = _piecePosition;

-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _piecePosition = [[Position alloc] init];
    
    return self;
}

- (id) initWithImage:(NSString *)type {
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
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
    else if([type isEqualToString:@"Mannequin"]){
        _icon = [UIImage imageNamed:@"mannequin"];
    }
    else if([type isEqualToString:@"Bridge"]){
        _icon = [UIImage imageNamed:@"bridge"];
    }
    else if([type isEqualToString:@"Circle"]){
        _icon = [UIImage imageNamed:@"circle"];
    }
    else if([type isEqualToString:@"Square"]){
        _icon = [UIImage imageNamed:@"square"];
    }
    else if([type isEqualToString:@"Black Stairs"]){
        _icon = [UIImage imageNamed:@"stairs"];
    }
    else if([type isEqualToString:@"Water"]){
        _icon = [UIImage imageNamed:@"water"];
    }
    else if([type isEqualToString:@"brickWall"]){
        _icon = [UIImage imageNamed:@"brickWall"];
    }
    else if([type isEqualToString:@"fence"]){
        _icon = [UIImage imageNamed:@"fence"];
    }
    else if([type isEqualToString:@"gate"]){
        _icon = [UIImage imageNamed:@"gate"];
    }
    else if([type isEqualToString:@"couch"]){
        _icon = [UIImage imageNamed:@"couch"];
    }
    else if([type isEqualToString:@"cactus"]){
        _icon = [UIImage imageNamed:@"cactus"];
    }
    else if([type isEqualToString:@"chair"]){
        _icon = [UIImage imageNamed:@"chair"];
    }
    else if([type isEqualToString:@"flower"]){
        _icon = [UIImage imageNamed:@"flower"];
    }
    else if([type isEqualToString:@"Bush"]){//
        _icon = [UIImage imageNamed:@"bush1"];
    }
    else if([type isEqualToString:@"woodChair"]){
        _icon = [UIImage imageNamed:@"chair1"];
    }
    else if([type isEqualToString:@"redChair"]){
        _icon = [UIImage imageNamed:@"chair2"];
    }
    else if([type isEqualToString:@"steelChair"]){
        _icon = [UIImage imageNamed:@"chair3"];
    }
    else if([type isEqualToString:@"flowerPot"]){//
        _icon = [UIImage imageNamed:@"flowerpot1"];
    }
    else if([type isEqualToString:@"ladder"]){//
        _icon = [UIImage imageNamed:@"ladder"];
    }
    else if([type isEqualToString:@"log"]){//
        _icon = [UIImage imageNamed:@"log"];
    }
    else if([type isEqualToString:@"nightstand"]){
        _icon = [UIImage imageNamed:@"nightstand"];
    }
    else if([type isEqualToString:@"Podium"]){//
        _icon = [UIImage imageNamed:@"Podium"];
    }
    else if([type isEqualToString:@"Rock"]){//
        _icon = [UIImage imageNamed:@"rock1"];
    }
    else if([type isEqualToString:@"Sand"]){//
        _icon = [UIImage imageNamed:@"Sand"];
    }
    else if([type isEqualToString:@"SpiralStair"]){//
        _icon = [UIImage imageNamed:@"Spiral_Staircase"];
    }
    else if([type isEqualToString:@"stump"]){//
        _icon = [UIImage imageNamed:@"stump"];
    }
    else if([type isEqualToString:@"table"]){
        _icon = [UIImage imageNamed:@"table1"];
    }
    else if([type isEqualToString:@"roundTable"]){
        _icon = [UIImage imageNamed:@"table2"];
    }
    else { // blank cell
        _icon = [UIImage imageNamed:@"production-settings"];
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setPiecePosition:[self.piecePosition copyWithZone:zone]];
		[copy setIcon:[UIImage imageWithCGImage:self.icon.CGImage]];
	}
	return copy;
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
