Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandApplier,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
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

{ #category : #'command operations' }
ToSelectionModelOperator >> listScrollCommand: aCommand for: aTarget [

	aTarget scrollToIndex: aCommand index
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
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
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand for: aEventTarget [

	self selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex.
	" Must take car of unselectable items: "
	" for adding items, no need to notify change because it is already done here but when
	when removing items (itemCount < 0) one have to notify change to the datasource 
	to correctly update the UI"
	aShiftCommand itemCount > 0 ifTrue: [ ^ self ].
	aShiftCommand fromIndex <= self selectionModel itemCount ifTrue: [
		aEventTarget dataSource notifyChanged ]

]

{ #category : #accessing }
ToSelectionModelOperator >> sharedEvents [

	^ super sharedEvents , {
		  ToPrimarySelectionCommandAppliedEvent.
		  ToListPrimarySelectionChangedEvent }
]
