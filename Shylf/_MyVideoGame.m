// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyVideoGame.m instead.

#import "_MyVideoGame.h"

const struct MyVideoGameAttributes MyVideoGameAttributes = {
	.platform = @"platform",
	.title = @"title",
};

const struct MyVideoGameRelationships MyVideoGameRelationships = {
};

const struct MyVideoGameFetchedProperties MyVideoGameFetchedProperties = {
};

@implementation MyVideoGameID
@end

@implementation _MyVideoGame

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyVideoGame" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyVideoGame";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyVideoGame" inManagedObjectContext:moc_];
}

- (MyVideoGameID*)objectID {
	return (MyVideoGameID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic platform;






@dynamic title;











@end
