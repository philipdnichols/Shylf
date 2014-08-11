// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TVShow.m instead.

#import "_TVShow.h"

const struct TVShowAttributes TVShowAttributes = {
	.title = @"title",
};

const struct TVShowRelationships TVShowRelationships = {
};

const struct TVShowFetchedProperties TVShowFetchedProperties = {
};

@implementation TVShowID
@end

@implementation _TVShow

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TVShow" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TVShow";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TVShow" inManagedObjectContext:moc_];
}

- (TVShowID*)objectID {
	return (TVShowID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic title;











@end
