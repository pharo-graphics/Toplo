Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#traits : 'TToPostponedCommandHolder',
	#classTraits : 'TToPostponedCommandHolder classTrait',
	#instVars : [
		'finalStepCommands'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> addPostponedCommand: aCommand [

	finalStepCommands add: aCommand
]

{ #category : #'commands processing' }
ToInfiniteDataSourceManager >> consumeFinalStepCommandsIn: anElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume finale step updates (if there is)."

	self consumePostponedCommandsIn: anElement
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> consumePostponedCommand: aCommand in: anElement [

	self dispatchCommand: aCommand to: anElement.
	self onCommandProcessed: aCommand in: anElement.
	self recycleCommand: aCommand
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> hasPostponedCommand [

	^ finalStepCommands notEmpty
]

{ #category : #initialization }
ToInfiniteDataSourceManager >> initialize [
	super initialize.
	
	finalStepCommands := OrderedCollection new.
]

{ #category : #'t - postponed command holder' }
ToInfiniteDataSourceManager >> nextPostponedCommand [

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
ToInfiniteDataSourceManager >> postponeAction: aValuable [

	self postponeCommand: (ToInfiniteDataSourceActionCommand new
			 action: aValuable;
			 yourself)
]
