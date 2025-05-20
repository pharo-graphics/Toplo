Class {
	#name : #ToTreeDataAccessorEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'data events handling' }
ToTreeDataAccessorEventHandler >> collectionAddEvent: anEvent [

	| dataAccessor treeElement |
	dataAccessor := anEvent currentTarget.
	treeElement := dataAccessor treeElement.
	anEvent interval do: [ :idx |
		| w |
		w := dataAccessor newWrapperAt: idx.
		treeElement dataSource add: w beforeIndex: idx ]
]

{ #category : #'data events handling' }
ToTreeDataAccessorEventHandler >> collectionAllUpdatedEvent: anEvent [

	| dataAccessor treeElement |
	dataAccessor := anEvent currentTarget.
	treeElement := dataAccessor treeElement.
	treeElement dataSource updateAllWith: (dataAccessor collectWithIndex: [ :d :idx |
			 dataAccessor newWrapperAt: idx ])
]

{ #category : #'data events handling' }
ToTreeDataAccessorEventHandler >> collectionRemoveEvent: anEvent [

	| dataAccessor treeElement |
	dataAccessor := anEvent currentTarget.
	treeElement := dataAccessor treeElement.
	treeElement dataSource
		removeFrom: anEvent interval first
		to: anEvent interval last
]

{ #category : #'data events handling' }
ToTreeDataAccessorEventHandler >> collectionUpdateEvent: anEvent [

	| dataAccessor treeElement |
	self halt.
	dataAccessor := anEvent currentTarget.
	treeElement := dataAccessor treeElement.
	anEvent interval do: [ :idx |
		| w |
		w := dataAccessor newWrapperAt: idx.
		treeElement dataSource at: idx put: w ]
]
