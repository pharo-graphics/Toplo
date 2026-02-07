Class {
	#name : #ToObservableCollectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionAddEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionEmptinessEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionFilteredEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionRemoveEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionSievedEvent: anEvent [

]

{ #category : #'data events handling' }
ToObservableCollectionEventHandler >> collectionUpdateEvent: anEvent [

]

{ #category : #'api - accessing' }
ToObservableCollectionEventHandler >> eventsToHandle [

	^ { ToCollectionEmptinessEvent. ToObservableCollectionEvent }
]
