// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyMovieGenre.m instead.

#import "_MyMovieGenre.h"

const struct MyMovieGenreAttributes MyMovieGenreAttributes = {
	.identifier = @"identifier",
	.name = @"name",
};

const struct MyMovieGenreRelationships MyMovieGenreRelationships = {
	.movies = @"movies",
};

const struct MyMovieGenreFetchedProperties MyMovieGenreFetchedProperties = {
};

@implementation MyMovieGenreID
@end

@implementation _MyMovieGenre

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyMovieGenre" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyMovieGenre";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyMovieGenre" inManagedObjectContext:moc_];
}

- (MyMovieGenreID*)objectID {
	return (MyMovieGenreID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic identifier;



- (int16_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result shortValue];
}

- (void)setIdentifierValue:(int16_t)value_ {
	[self setIdentifier:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdentifierValue {
	NSNumber *result = [self primitiveIdentifier];
	return [result shortValue];
}

- (void)setPrimitiveIdentifierValue:(int16_t)value_ {
	[self setPrimitiveIdentifier:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic movies;

	






@end
