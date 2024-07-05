Class {
	#name : #ToSelectionModelOperator,
	#superclass : #Object,
	#instVars : [
		'currentIndex'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	| intervals |
	aCommand indexes ifEmpty: [
		self changeCurrentIndexWith: 0.
		^ self ].
	aCommand operation deselectAllBefore ifTrue: [
		aCommand selectionModel deselectAll ].
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i |
		aCommand selectionModel selectIndex: i first to: i last ].
	self changeCurrentIndexWith: aCommand indexes last
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		aCommand selectionModel deselectAll ].
	aCommand selectionModel selectIndex: aCommand from to: aCommand to.
	self changeCurrentIndexWith: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	aCommand selectionModel selectAll.
	self changeCurrentIndexWith: aCommand selectionModel itemCount
]

{ #category : #accessing }
ToSelectionModelOperator >> changeCurrentIndexWith: anIndex [

	self currentIndex: anIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #initialization }
ToSelectionModelOperator >> initialize [ 

	super initialize.
	currentIndex := 0
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
	self changeCurrentIndexWith: 0.
	aCommand indexes ifEmpty: [ ^ self ].
	intervals := self intervalsIn: aCommand indexes.
	intervals do: [ :i | aCommand selectionModel deselectIndex: i first to: i last ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	aCommand selectionModel deselectIndex: aCommand from to: aCommand to.
	self changeCurrentIndexWith: (aCommand from min: aCommand to)
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	aCommand selectionModel deselectAll.
	self changeCurrentIndexWith: 0
]

{ #category : #'command operations' }
ToSelectionModelOperator >> scrollCommand: aCommand [

	| target index |
	target := aCommand target.
	index := aCommand index.

	aCommand towardEnd
		ifTrue: [ target scrollTowardEndToDataSourcePosition: index ]
		ifFalse: [ target scrollTowardStartToDataSourcePosition: index ]
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelCopyFromCommand: aCopyFromCommand [ 

	aCopyFromCommand selectionModel copySelectionFrom:  aCopyFromCommand sourceSelectionModel.
	self changeCurrentIndexWith: 0
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand [ 

	aShiftCommand selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex
]
