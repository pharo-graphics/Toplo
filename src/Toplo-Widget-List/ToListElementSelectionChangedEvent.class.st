Class {
	#name : #ToListElementSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'currentIndexes',
		'previousIndexes'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #accessing }
ToListElementSelectionChangedEvent >> currentIndexes [

	^ currentIndexes
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> currentIndexes: currentSelectedIndexes [

	currentIndexes := currentSelectedIndexes copy
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> newSelectedIndexes [

	self
		deprecated: 'Use currentIndexes instead'
		transformWith: '`@receiver newSelectedIndexes '
			->
			'`@receiver currentIndexes '.

	^ self currentIndexes
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> newSelectedIndexes: anArray [

	self
		deprecated: 'Use currentIndexes: instead'
		transformWith: '`@receiver newSelectedIndexes: `@arg '
			->
			'`@receiver currentIndexes: `@arg'.

	self currentIndexes: anArray
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> oldSelectedIndexes [

	self
		deprecated: 'Use previousIndexes instead'
		transformWith: '`@receiver oldSelectedIndexes '
			->
			'`@receiver previousIndexes '.

	^ self previousIndexes
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> oldSelectedIndexes: anArray [

	self
		deprecated: 'Use previousIndexes: instead'
		transformWith: '`@receiver oldSelectedIndexes: `@arg '
			->
			'`@receiver previousIndexes: `@arg'.

	self previousIndexes: anArray
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> previousIndexes [

	^ previousIndexes
]

{ #category : #accessing }
ToListElementSelectionChangedEvent >> previousIndexes: previousSelectedIndexes [

	previousIndexes := previousSelectedIndexes copy
]

{ #category : #sending }
ToListElementSelectionChangedEvent >> sendTo: anObject [

	anObject listElementSelectionChangedEvent: self
]
