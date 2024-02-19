Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #accessing }
ToListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #accessing }
ToListElement >> dataUpdater [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver dataUpdater'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #initialization }
ToListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToListElement >> defaultInfiniteElement [

	^ ToObservableCollectionInfiniteElement new
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents, { ToObservableCollectionEvent }
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #accessing }
ToListElement >> selectionStrategy [

	self
		deprecated: 'Use selecter instead'
		transformWith: '`@receiver selectionStrategy' -> '`@receiver selecter'.

	^ self selecter
]
