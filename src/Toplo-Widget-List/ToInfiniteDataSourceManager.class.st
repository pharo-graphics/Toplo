Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#instVars : [
		'finalStepCommands'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'commands processing' }
ToInfiniteDataSourceManager >> consumeFinalStepCommandsIn: anInfiniteElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume finale step updates (if there is)."

	[ finalStepCommands isEmpty ] whileFalse: [
		| cmd |
		cmd := finalStepCommands removeFirst.
		self dispatchCommand: cmd to: anInfiniteElement.
		self onCommandProcessed: cmd in: anInfiniteElement.
		self recycleCommand: cmd ].
]

{ #category : #initialization }
ToInfiniteDataSourceManager >> initialize [
	super initialize.
	
	finalStepCommands := OrderedCollection new.
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemsFiltered: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"
	finalStepCommands add: (ToInfiniteDataSourceFilterCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself).

	^ finalStepCommands notEmpty
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemsSieved: aPositionStart itemCount: anItemCount with: aSieve [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register the sieve command"
	finalStepCommands add: (ToInfiniteDataSourceSieveCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 sieve: aSieve;
			 yourself).

	^ finalStepCommands notEmpty
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onSelecterCommand: aCommand appliedBy: aSelecter [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"

	finalStepCommands add: (ToSelecterCommandApplication new
			 selecter: aSelecter;
			 command: aCommand;
			 yourself).

	^ true
]
