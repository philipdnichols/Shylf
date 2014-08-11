// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VideoGame.m instead.

#import "_VideoGame.h"

const struct VideoGameAttributes VideoGameAttributes = {
	.platform = @"platform",
	.title = @"title",
};

const struct VideoGameRelationships VideoGameRelationships = {
};

const struct VideoGameFetchedProperties VideoGameFetchedProperties = {
};

@implementation VideoGameID
@end

@implementation _VideoGame

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"VideoGame" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"VideoGame";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"VideoGame" inManagedObjectContext:moc_];
}

- (VideoGameID*)objectID {
	return (VideoGameID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic platform;






@dynamic title;











@end
