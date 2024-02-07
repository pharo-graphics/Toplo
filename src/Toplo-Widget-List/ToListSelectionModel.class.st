Class {
	#name : #ToListSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'currentIndex',
		'distance',
		'pivot',
		'selectionCommandChecker'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'command handling' }
ToListSelectionModel >> addIndexesSelectionCommand: aCommand [

	super addIndexesSelectionCommand: aCommand.
	self markPointedPosition: aCommand indexes first
]

{ #category : #'command handling' }
ToListSelectionModel >> addIntervalSelectionCommand: aCommand [

	super addIntervalSelectionCommand: aCommand.
	self markPointedPosition: aCommand to
]

{ #category : #'command handling' }
ToListSelectionModel >> addWholeSelectionCommand: aCommand [

	super addWholeSelectionCommand: aCommand.
	self markPointedPosition: 0
]

{ #category : #'command handling' }
ToListSelectionModel >> applyCommand: aCommand [

	self selectionCommandChecker ifNotNil: [ :checker | aCommand applyOn: checker ].
	super applyCommand: aCommand
]

{ #category : #'private - operations' }
ToListSelectionModel >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #accessing }
ToListSelectionModel >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToListSelectionModel >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToListSelectionModel >> distance [

	^ distance
]

{ #category : #accessing }
ToListSelectionModel >> distance: anInteger [

	distance := anInteger
]

{ #category : #'private - operations' }
ToListSelectionModel >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < self itemCount ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - operations' }
ToListSelectionModel >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self markPointedPosition: self itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: self itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #'private - operations' }
ToListSelectionModel >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	self currentIndex: anInteger.

]

{ #category : #accessing }
ToListSelectionModel >> pivot [

	^ pivot
]

{ #category : #accessing }
ToListSelectionModel >> pivot: anInteger [

	pivot := anInteger
]

{ #category : #'command handling' }
ToListSelectionModel >> removeIndexesSelectionCommand: aCommand [

	super removeIndexesSelectionCommand: aCommand.
	self markPointedPosition: aCommand indexes first
]

{ #category : #'command handling' }
ToListSelectionModel >> removeIntervalSelectionCommand: aCommand [

	super removeIntervalSelectionCommand: aCommand.
	self markPointedPosition: aCommand from
]

{ #category : #'command handling' }
ToListSelectionModel >> removeWholeSelectionCommand: aCommand [

	super removeWholeSelectionCommand: aCommand.
	self markPointedPosition: 0
]

{ #category : #accessing }
ToListSelectionModel >> selectionCommandChecker [

	^ selectionCommandChecker 
]

{ #category : #accessing }
ToListSelectionModel >> selectionCommandChecker: aSelectionCommandChecker [

	selectionCommandChecker := aSelectionCommandChecker
]
