// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyBook.m instead.

#import "_MyBook.h"

const struct MyBookAttributes MyBookAttributes = {
	.author = @"author",
	.title = @"title",
};

const struct MyBookRelationships MyBookRelationships = {
};

const struct MyBookFetchedProperties MyBookFetchedProperties = {
};

@implementation MyBookID
@end

@implementation _MyBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyBook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyBook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyBook" inManagedObjectContext:moc_];
}

- (MyBookID*)objectID {
	return (MyBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic author;






@dynamic title;











@end
