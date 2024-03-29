Class {
	#name : #ToObservableCollectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionAddEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionAddRequest: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionAllUpdatedEvent: anEvent [

	
]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionEmptinessEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionFilterRequest: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionFilteredEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionRemoveEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionRemoveRequest: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionUpdateAllRequest: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionUpdateEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionUpdateRequest: anEvent [

]

{ #category : #'api - accessing' }
ToObservableCollectionEventHandler >> eventsToHandle [

	^ { ToObservableCollectionEvent }
]
