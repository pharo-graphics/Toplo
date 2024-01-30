Class {
	#name : #ToInfiniteSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'currentIndexes',
		'previousIndexes'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'instance creation' }
ToInfiniteSelectionChangedEvent class >> from: previousSelectedIndexes to: currentSelectedIndexes [

	self
		deprecated: 'Use oldSelectedIndexes:newSelectedIndexes: instead'
		transformWith: '`@receiver from: `@argument1 to: `@argument2 '
			->
			'`@receiver previousIndexes: `@argument1 currentIndexes: `@argument2 '.

	^ self
		  previousIndexes: previousSelectedIndexes
		  currentIndexes: currentSelectedIndexes;
		  yourself
]

{ #category : #testing }
ToInfiniteSelectionChangedEvent class >> isDeprecated [ 

	^ true
]

{ #category : #'instance creation' }
ToInfiniteSelectionChangedEvent class >> previousIndexes: previousSelectedIndexes currentIndexes: currentSelectedIndexes [

	^ self new
		  previousIndexes: previousSelectedIndexes;
		  currentIndexes: currentSelectedIndexes;
		  yourself
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> currentIndexes [

	^ currentIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> currentIndexes: currentSelectedIndexes [

	currentIndexes := currentSelectedIndexes "asSet"
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> newSelectedIndexes [

	self
		deprecated: 'Use currentIndexes instead'
		transformWith: '`@receiver newSelectedIndexes '
			->
			'`@receiver currentIndexes '.

	^ self currentIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> newSelectedIndexes: anArray [

	self
		deprecated: 'Use currentIndexes: instead'
		transformWith: '`@receiver newSelectedIndexes: `@arg '
			->
			'`@receiver currentIndexes: `@arg'.

	self currentIndexes: anArray
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> oldSelectedIndexes [

	self
		deprecated: 'Use previousIndexes instead'
		transformWith: '`@receiver oldSelectedIndexes '
			->
			'`@receiver previousIndexes '.

	^ self previousIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> oldSelectedIndexes: anArray [

	self
		deprecated: 'Use previousIndexes: instead'
		transformWith: '`@receiver oldSelectedIndexes: `@arg '
			->
			'`@receiver previousIndexes: `@arg'.

	self previousIndexes: anArray
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> previousIndexes [

	^ previousIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> previousIndexes: previousSelectedIndexes [

	previousIndexes := previousSelectedIndexes "asSet"
]

{ #category : #sending }
ToInfiniteSelectionChangedEvent >> sendTo: anObject [

	anObject infiniteSelectionChangedEvent: self
]
