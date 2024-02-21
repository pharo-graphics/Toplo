Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangedEvent >> currentIndexes [

	self
		deprecated: 'Use #selectionModel instead '
		transformWith: '`@receiver currentIndexes '
			->
			'`@receiver selectedIndexes '.
	^ self selectedIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> currentIndexes: currentSelectedIndexes [

	self
		deprecated: 'Use #selectionModel: instead '
]

{ #category : #accessing }
ToListSelectionChangedEvent >> newSelectedIndexes [

	self
		deprecated: 'Use currentIndexes instead'
		transformWith: '`@receiver newSelectedIndexes '
			->
			'`@receiver currentIndexes '.

	^ self selectedIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> newSelectedIndexes: anArray [

	self
		deprecated: 'Use selectionModel instead'.
]

{ #category : #accessing }
ToListSelectionChangedEvent >> oldSelectedIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListSelectionChangedEvent >> oldSelectedIndexes: anArray [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListSelectionChangedEvent >> previousIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListSelectionChangedEvent >> previousIndexes: previousSelectedIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListSelectionChangedEvent >> sendTo: anObject [

	anObject listSelectionChangedEvent: self
]
