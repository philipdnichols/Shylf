// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MyMovie.m instead.

#import "_MyMovie.h"

const struct MyMovieAttributes MyMovieAttributes = {
	.overview = @"overview",
	.rating = @"rating",
	.releaseDate = @"releaseDate",
	.runtime = @"runtime",
	.tagline = @"tagline",
	.thumbnailURL = @"thumbnailURL",
	.title = @"title",
};

const struct MyMovieRelationships MyMovieRelationships = {
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




@dynamic overview;






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






@dynamic thumbnailURL;






@dynamic title;











@end
