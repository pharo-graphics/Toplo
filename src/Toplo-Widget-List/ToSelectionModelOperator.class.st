Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToListCommandOperator,
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
	aCommand operation deselectAllBefore ifTrue: [
		aCommand selectionModel deselectAll ].
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i |
		aCommand selectionModel selectIndex: i first to: i last ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		aCommand selectionModel deselectAll ].
	aCommand selectionModel selectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	aCommand selectionModel selectAll
]

{ #category : #accessing }
ToSelectionModelOperator >> currentIndex: anIndex [
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

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [ ^ self ].
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i | aCommand selectionModel deselectIndex: i first to: i last ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	aCommand selectionModel deselectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	aCommand selectionModel deselectAll
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelCopyFromCommand: aCopyFromCommand [ 

	aCopyFromCommand selectionModel copySelectionFrom:  aCopyFromCommand sourceSelectionModel
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand [ 

	aShiftCommand selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex.
	" Must take car of unselectable items: "
	" for adding items, no need to notify change because it is already done here but when
	when removing items (itemCount < 0) one have to notify change to the datasource 
	to correctly update the UI"
	aShiftCommand itemCount > 0 ifTrue: [ ^ self ].
	aShiftCommand fromIndex <= aShiftCommand selectionModel itemCount ifTrue: [
		"aEventTarget dataSource notifyChanged" ]

]
