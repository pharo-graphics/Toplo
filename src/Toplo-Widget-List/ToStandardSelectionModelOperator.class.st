Class {
	#name : #ToStandardSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'currentIndex',
		'primary'
	],
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #'instance creation' }
ToStandardSelectionModelOperator class >> primary [

	^ self new primary: true
]

{ #category : #'instance creation' }
ToStandardSelectionModelOperator class >> secondary [

	^ self new primary: false
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	super addIndexesSelectionCommand: aCommand.
	aCommand indexes ifEmpty: [
		self changeCurrentIndexWith: 0.
		^ self ].
	self changeCurrentIndexWith: aCommand indexes last
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	super addIntervalSelectionCommand: aCommand.
	self changeCurrentIndexWith: aCommand to
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	super addWholeSelectionCommand: aCommand.
	self changeCurrentIndexWith: aCommand selectionModel itemCount
]

{ #category : #accessing }
ToStandardSelectionModelOperator >> changeCurrentIndexWith: anIndex [

	self currentIndex: anIndex
]

{ #category : #accessing }
ToStandardSelectionModelOperator >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToStandardSelectionModelOperator >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #initialization }
ToStandardSelectionModelOperator >> initialize [ 

	super initialize.
	currentIndex := 0.
	primary := true
]

{ #category : #accessing }
ToStandardSelectionModelOperator >> primary: aBoolean [

	primary := aBoolean
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	super removeIndexesSelectionCommand: aCommand.
	self changeCurrentIndexWith: 0
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	super removeIntervalSelectionCommand: aCommand.
	self changeCurrentIndexWith: (aCommand from min: aCommand to)
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	super removeWholeSelectionCommand: aCommand.
	self changeCurrentIndexWith: 0
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> scrollCommand: aCommand [

	| target index |
	target := aCommand target.
	index := aCommand index.

	" In case of a secondary selection, to ensure that wrap-around when scrolling works as expected. 
	If not done, the wrap-around comme back to the last mouse move event position"
	primary ifFalse: [
		target spaceDo: [ :sp |
			sp mouseProcessor lastMouseMoveEvent ifNotNil: [ :e | e consume ] ] ].

	aCommand towardEnd
		ifTrue: [ target scrollTowardEndToDataSourcePosition: index ]
		ifFalse: [ target scrollTowardStartToDataSourcePosition: index ]
]

{ #category : #'command operations' }
ToStandardSelectionModelOperator >> selectionModelCopyFromCommand: aCopyFromCommand [ 

	super selectionModelCopyFromCommand: aCopyFromCommand.
	self changeCurrentIndexWith: 0
]
