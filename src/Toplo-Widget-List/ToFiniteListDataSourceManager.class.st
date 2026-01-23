Class {
	#name : #ToFiniteListDataSourceManager,
	#superclass : #Object,
	#traits : 'TToPostponedCommandManager',
	#classTraits : 'TToPostponedCommandManager classTrait',
	#instVars : [
		'commandApplicationStrategy',
		'finiteListElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> addCommand: aCommand [

	commandApplicationStrategy addCommand: aCommand from: self
]

{ #category : #'command application' }
ToFiniteListDataSourceManager >> applyCommand: aCommand [

	aCommand applyIn: finiteListElement
]

{ #category : #initialization }
ToFiniteListDataSourceManager >> defaultCommandApplicationStrategy [ 

	" The immediate strategy is mandatory, the other will not work "
	"^ BlQueueBasedCommandApplicationStrategy new"
	"^ BlTaskBasedCommandApplicationStrategy new"
	^ BlImmediateCommandApplicationStrategy new
]

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> dispatchCommand: aCommand to: anInfiniteElement [
	"Dispatch data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: anInfiniteElement layout
]

{ #category : #testing }
ToFiniteListDataSourceManager >> hasPendingCommands [

	^ commandApplicationStrategy hasPendingCommands
]

{ #category : #accessing }
ToFiniteListDataSourceManager >> innerListElement: anInnerListElement [

	finiteListElement := anInnerListElement.
	commandApplicationStrategy := self defaultCommandApplicationStrategy
		                              element: anInnerListElement;
		                              yourself.
		
]

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> onCommandProcessed: aCommand in: anInfiniteElement [

	aCommand offsetPositionsIn: anInfiniteElement.
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	anItemCount < 1 ifTrue: [ ^ self ].

	"Register update command"
	self addCommand: (ToListDataSourceUpdateCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself)
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	anItemCount < 1
		ifTrue: [ ^ self ].
	"Register add command"
	self addCommand: (ToListDataSourceAddCommand new
			positionStart: aPositionStart;
			itemCount: anItemCount)
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	anItemCount < 1
		ifTrue: [ ^ self ].
		
	"Register remove command"
	self addCommand: (ToListDataSourceRemoveCommand new
		positionStart: aPositionStart;
		itemCount: anItemCount;
		yourself)
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsChanged [ 

	self addCommand: ToListDataSourceChangedCommand new
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsFiltered: aPositionStart itemCount: anItemCount [
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
ToFiniteListDataSourceManager >> onItemsSieved: aPositionStart itemCount: anItemCount with: aSieve [
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

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> recycleCommand: aCommand [
	"Recycle aCommand if recycling enabled"

]
