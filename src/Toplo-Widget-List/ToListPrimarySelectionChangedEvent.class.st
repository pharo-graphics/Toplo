Class {
	#name : #ToListPrimarySelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> currentIndexes [

	self
		deprecated: 'Use #selectionModel instead '
		transformWith: '`@receiver currentIndexes '
			->
			'`@receiver selectedIndexes '.
	^ self selectedIndexes
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> currentIndexes: currentSelectedIndexes [

	self
		deprecated: 'Use #selectionModel: instead '
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> newSelectedIndexes [

	self
		deprecated: 'Use currentIndexes instead'
		transformWith: '`@receiver newSelectedIndexes '
			->
			'`@receiver currentIndexes '.

	^ self selectedIndexes
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> newSelectedIndexes: anArray [

	self
		deprecated: 'Use selectionModel instead'.
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> oldSelectedIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> oldSelectedIndexes: anArray [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> previousIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> previousIndexes: previousSelectedIndexes [

	self
		deprecated: 'Not used anymore'
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListPrimarySelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListPrimarySelectionChangedEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangedEvent: self
]
