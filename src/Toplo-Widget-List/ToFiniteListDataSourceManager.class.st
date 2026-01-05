Class {
	#name : #ToFiniteListDataSourceManager,
	#superclass : #Object,
	#traits : 'TToPostponedCommandManager',
	#classTraits : 'TToPostponedCommandManager classTrait',
	#instVars : [
		'pendingCommands'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> consumeCommandsIn: aFiniteElement [

	[ pendingCommands isEmpty ] whileFalse: [
		| cmd |
		cmd := pendingCommands removeFirst.
		self dispatchCommand: cmd to: aFiniteElement.
		self onCommandProcessed: cmd in: aFiniteElement.
		self recycleCommand: cmd ].
	self consumeFinalStepCommandsIn: aFiniteElement
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
	"Return true if there are pending commands,
	false otherwise"

	^ pendingCommands isNotEmpty
]

{ #category : #initialization }
ToFiniteListDataSourceManager >> initialize [
	super initialize.
	
	pendingCommands := OrderedCollection new
]

{ #category : #accessing }
ToFiniteListDataSourceManager >> innerListElement: anInnerBarElement [

	
]

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> onCommandProcessed: aCommand in: anInfiniteElement [

	aCommand offsetPositionsIn: anInfiniteElement.
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	"Enqueues a new update pending command.
	I am a part of public API and should be triggered by data source (directly or indirectly)
	when items are changed/updated (item's value, content, or value was replaced in-place).
	Return true if pending commands need to be processed, otherwise false."

	"If no items where updated we do nothing"
	"innerListElement onItemRangeChanged: aPositionStart itemCount: anItemCount"

	anItemCount < 1 ifTrue: [ ^ false ].

	"Register update command"
	pendingCommands add: (BlInfiniteDataSourceUpdateCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself).

	^ pendingCommands notEmpty

	
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	"innerListElement onItemRangeInserted: aPositionStart itemCount: anItemCount.
	innerListElement listElement selecter
		shiftSelection: anItemCount
		from: aPositionStart"
		
	"Return true if pending commands should be processed,
	otherwise false"

	"If no items where updated we do nothing"

	anItemCount < 1
		ifTrue: [ ^ false ].
	"Register add command"
	pendingCommands add: (BlInfiniteDataSourceAddCommand new
			positionStart: aPositionStart;
			itemCount: anItemCount).

	^ pendingCommands notEmpty
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	"innerListElement onItemRangeRemoved: aPositionStart itemCount: anItemCount.
	"" update the secondary selection because it can be on the removed nodes ""
	innerListElement listElement secondarySelecter
		deselectIndex: aPositionStart
		to: aPositionStart + anItemCount - 1.
	innerListElement listElement selecter
		shiftSelection: anItemCount negated
		from: aPositionStart"
	"If no items where updated we do nothing"

	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register remove command"
	pendingCommands add: (BlInfiniteDataSourceRemoveCommand new
		positionStart: aPositionStart;
		itemCount: anItemCount;
		yourself).
		
	^ pendingCommands notEmpty
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
