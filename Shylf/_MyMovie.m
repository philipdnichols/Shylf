// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyMovie.m instead.

#import "_MyMovie.h"

const struct MyMovieAttributes MyMovieAttributes = {
	.identifier = @"identifier",
	.overview = @"overview",
	.posterFileURL = @"posterFileURL",
	.rating = @"rating",
	.releaseDate = @"releaseDate",
	.runtime = @"runtime",
	.tagline = @"tagline",
	.thumbnailFileURL = @"thumbnailFileURL",
	.title = @"title",
};

const struct MyMovieRelationships MyMovieRelationships = {
	.genres = @"genres",
};

const struct MyMovieFetchedProperties MyMovieFetchedProperties = {
};

@implementation MyMovieID
@end

@implementation _MyMovie

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MyMovie" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MyMovie";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MyMovie" inManagedObjectContext:moc_];
}

- (MyMovieID*)objectID {
	return (MyMovieID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"runtimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"runtime"];
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





@dynamic overview;






@dynamic posterFileURL;






@dynamic rating;



- (float)ratingValue {
	NSNumber *result = [self rating];
	return [result floatValue];
}

- (void)setRatingValue:(float)value_ {
	[self setRating:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result floatValue];
}

- (void)setPrimitiveRatingValue:(float)value_ {
	[self setPrimitiveRating:[NSNumber numberWithFloat:value_]];
}





@dynamic releaseDate;






@dynamic runtime;



- (int16_t)runtimeValue {
	NSNumber *result = [self runtime];
	return [result shortValue];
}

- (void)setRuntimeValue:(int16_t)value_ {
	[self setRuntime:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRuntimeValue {
	NSNumber *result = [self primitiveRuntime];
	return [result shortValue];
}

- (void)setPrimitiveRuntimeValue:(int16_t)value_ {
	[self setPrimitiveRuntime:[NSNumber numberWithShort:value_]];
}





@dynamic tagline;






@dynamic thumbnailFileURL;






@dynamic title;






@dynamic genres;

	
- (NSMutableSet*)genresSet {
	[self willAccessValueForKey:@"genres"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"genres"];
  
	[self didAccessValueForKey:@"genres"];
	return result;
}
	






@end
