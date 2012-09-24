
@class Parsing;

@protocol ParsingDelegate


@required

- (void) fetchDataSuccess;
- (void) fetchDataFail:(NSError *)error;

@end