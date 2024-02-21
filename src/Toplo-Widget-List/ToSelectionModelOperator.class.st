Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandApplier,
	#instVars : [
		'selectionModel',
		'previousModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel selectAllIndexes: aCommand indexes.
	"intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i | self selectionModel selectIndex: i first to: i last ]"
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
	silent ifTrue: [ ^ self ].

	aTarget notifySelectionChanged: (ToListSelectionChangedEvent new
			 selectionModel: previousModel;
			 yourself)
]

{ #category : #private }
ToSelectionModelOperator >> intervalsIn: aCollection [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	| sorted |
	sorted := aCollection asOrderedCollection sort.
	^ Array streamContents: [ :stream |
		  | g prev |
		  g := nil.
		  prev := nil.
		  sorted do: [ :idx |
			  (prev isNil or: [ prev + 1 = idx ])
				  ifTrue: [
				  g := g ifNil: [ idx to: idx ] ifNotNil: [ g first to: idx ] ]
				  ifFalse: [
					  g ifNotNil: [
						  stream nextPut: g.
						  g := nil ] ].
			  prev := idx.
			  g := idx to: idx ].
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

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel deselectAllIndexes: aCommand indexes.
	"intervals := self intervalsIn: aCommand indexes.
	intervals reverseDo: [ :i | self selectionModel deselectIndex: i first to: i last ]"
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
