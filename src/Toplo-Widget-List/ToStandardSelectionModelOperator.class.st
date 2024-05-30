Class {
	#name : #ToStandardSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'currentIndex'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

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
	currentIndex := 0
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
ToStandardSelectionModelOperator >> selectionModelCopyFromCommand: aCopyFromCommand [ 

	super selectionModelCopyFromCommand: aCopyFromCommand.
	self changeCurrentIndexWith: 0
]
