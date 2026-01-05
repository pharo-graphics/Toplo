Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#instVars : [
		'finalStepCommands'
	],
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> addFinalStepCommand: aCommand [

	finalStepCommands add: aCommand
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> consumeFinalStepCommand: aCommand in: anElement [

	self dispatchCommand: aCommand to: anElement.
	self onCommandProcessed: aCommand in: anElement.
	self recycleCommand: aCommand
]

{ #category : #'commands processing' }
ToInfiniteDataSourceManager >> consumeFinalStepCommandsIn: anElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume finale step updates (if there is)."

	[ self hasFinalStepCommand ] whileTrue: [
		| cmd |
		cmd := self nextFinalStepCommand.
		self consumeFinalStepCommand: cmd in: anElement ] 
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> hasFinalStepCommand [

	^ finalStepCommands notEmpty
]

{ #category : #initialization }
ToInfiniteDataSourceManager >> initialize [
	super initialize.
	
	finalStepCommands := OrderedCollection new.
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> nextFinalStepCommand [

	^ finalStepCommands removeFirst
]

{ #category : #'data source updates' }
ToInfiniteDataSourceManager >> onItemsFiltered: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"
	self postponeCommand: (ToInfiniteDataSourceFilterCommand new
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
	self postponeCommand: (ToInfiniteDataSourceSieveCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 sieve: aSieve;
			 yourself).
	^ true
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> postponeAction: aValuable for: aTarget [

	self postponeCommand: (ToInfiniteDataSourceActionCommand new
			 action: [ aValuable cull: aTarget ];
			 yourself)
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> postponeCommand: aCommand [

	self addFinalStepCommand: aCommand 
]
