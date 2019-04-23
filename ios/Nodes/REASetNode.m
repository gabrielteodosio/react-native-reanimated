#import "REASetNode.h"
#import <React/RCTConvert.h>
#import <React/RCTLog.h>
#import "REAValueNode.h"
#import "REANodesManager.h"

@implementation REASetNode {
  NSNumber *_whatNodeID;
  NSNumber *_valueNodeID;
}

- (instancetype)initWithID:(REANodeID)nodeID config:(NSDictionary<NSString *,id> *)config
{
  if ((self = [super initWithID:nodeID config:config])) {
    _whatNodeID = [RCTConvert NSNumber:config[@"what"]];
    if (_whatNodeID == nil) {
      RCTLogError(
        @"Reanimated: First argument passed to set node is either of wrong type or is missing. NodeID: %@",
        self.nodeID
      );
    }
    _valueNodeID = [RCTConvert NSNumber:config[@"value"]];
    if (_valueNodeID == nil) {
      RCTLogError(
        @"Reanimated: Second argument passed to set node is either of wrong type or is missing. NodeID: %@",
        self.nodeID
      );
    }
  }
  return self;
}

- (id)evaluate
{
  NSNumber *newValue = [[self.nodesManager findNodeByID:_valueNodeID] value];
  REAValueNode *what = (REAValueNode *)[self.nodesManager findNodeByID:_whatNodeID];
  [what setValue:newValue];
  return newValue;
}

@end
