Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'currentIndexes',
		'previousIndexes'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #accessing }
ToListSelectionChangedEvent >> currentIndexes [

	^ currentIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> currentIndexes: currentSelectedIndexes [

	currentIndexes := currentSelectedIndexes copy
]

{ #category : #accessing }
ToListSelectionChangedEvent >> newSelectedIndexes [

	self
		deprecated: 'Use currentIndexes instead'
		transformWith: '`@receiver newSelectedIndexes '
			->
			'`@receiver currentIndexes '.

	^ self currentIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> newSelectedIndexes: anArray [

	self
		deprecated: 'Use currentIndexes: instead'
		transformWith: '`@receiver newSelectedIndexes: `@arg '
			->
			'`@receiver currentIndexes: `@arg'.

	self currentIndexes: anArray
]

{ #category : #accessing }
ToListSelectionChangedEvent >> oldSelectedIndexes [

	self
		deprecated: 'Use previousIndexes instead'
		transformWith: '`@receiver oldSelectedIndexes '
			->
			'`@receiver previousIndexes '.

	^ self previousIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> oldSelectedIndexes: anArray [

	self
		deprecated: 'Use previousIndexes: instead'
		transformWith: '`@receiver oldSelectedIndexes: `@arg '
			->
			'`@receiver previousIndexes: `@arg'.

	self previousIndexes: anArray
]

{ #category : #accessing }
ToListSelectionChangedEvent >> previousIndexes [

	^ previousIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> previousIndexes: previousSelectedIndexes [

	previousIndexes := previousSelectedIndexes copy
]

{ #category : #sending }
ToListSelectionChangedEvent >> sendTo: anObject [

	anObject listSelectionChangedEvent: self
]
