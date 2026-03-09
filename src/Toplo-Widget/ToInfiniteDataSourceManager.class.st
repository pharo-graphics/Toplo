Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#traits : 'TToPostponedCommandManager',
	#classTraits : 'TToPostponedCommandManager classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #adding }
ToInfiniteDataSourceManager >> addPendingCommand: aCommand [

	pendingCommands add: aCommand
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	super onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	super onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemsFiltered: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"
	self postponeCommand: (ToListDataSourceFilterCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself).
	^ true
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemsSieved: aPositionStart itemCount: anItemCount with: aSieve [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register the sieve command"
	self postponeCommand: (ToListDataSourceSieveCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 sieve: aSieve;
			 yourself).
	^ true
]
