Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandApplier,
	#instVars : [
		'selectionModel',
		'previousModel',
		'history'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
	"self selectionModel selectAllIndexes: aCommand indexes."
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i | self selectionModel selectIndex: i first to: i last ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	self selectionModel selectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	self selectionModel selectAll
]

{ #category : #'command application' }
ToSelectionModelOperator >> applyCommand: aCommand for: aTarget [

	| silent |
	previousModel ifNil: [ previousModel := self selectionModel copy ].

	super applyCommand: aCommand for: aTarget.

	silent := aCommand silent or: [ previousModel = self selectionModel ].

	previousModel = self selectionModel ifFalse: [
		aTarget dispatchEvent: (ToSelectionCommandAppliedEvent new
				 operator: self;
				 command: aCommand) ].

	previousModel := self selectionModel copy.
	history add: aCommand->previousModel.

	silent ifTrue: [ ^ self ].

	aTarget notifySelectionChanged: (ToListSelectionChangedEvent new
			 selectionModel: previousModel;
			 yourself)
]

{ #category : #initialization }
ToSelectionModelOperator >> initialize [ 

	super initialize.
	history := OrderedCollection new
]

{ #category : #private }
ToSelectionModelOperator >> intervalsIn: aCollection [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	| sorted |
	sorted := aCollection asOrderedCollection sort.
	^ Array streamContents: [ :stream |
		  | prev g |
		  g := nil.
		  prev := nil.
		  sorted do: [ :idx |
			  prev
				  ifNil: [
					  g := idx to: idx ]
				  ifNotNil: [
					  prev + 1 = idx
						  ifTrue: [ g := g first to: idx ]
						  ifFalse: [
							  stream nextPut: g.
							  g := idx to: idx ] ].
			  prev := idx ].
		  g ifNotNil: [ stream nextPut: g ] ]
]

{ #category : #accessing }
ToSelectionModelOperator >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	self selectionModel: anEventTarget selectionModel
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	self selectionModel: nil
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
	"self selectionModel deselectAllIndexes: aCommand indexes."
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i | self selectionModel deselectIndex: i first to: i last ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	self selectionModel deselectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	self selectionModel deselectAll
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand [

	self selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> sharedEvents [

	^ super sharedEvents , {
		  ToSelectionCommandAppliedEvent.
		  ToListSelectionChangedEvent }
]