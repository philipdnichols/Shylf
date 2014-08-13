// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyTVShow.m instead.

#import "_MyTVShow.h"

const struct MyTVShowAttributes MyTVShowAttributes = {
	.title = @"title",
};

const struct MyTVShowRelationships MyTVShowRelationships = {
};

const struct MyTVShowFetchedProperties MyTVShowFetchedProperties = {
};

@implementation MyTVShowID
@end

@implementation _MyTVShow

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyTVShow" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyTVShow";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyTVShow" inManagedObjectContext:moc_];
}

- (MyTVShowID*)objectID {
	return (MyTVShowID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic title;











@end
