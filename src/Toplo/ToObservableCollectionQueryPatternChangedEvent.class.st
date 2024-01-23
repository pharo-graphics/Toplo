Class {
	#name : #ToObservableCollectionQueryPatternChangedEvent,
	#superclass : #ToObservableCollectionQueryEvent,
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #sending }
ToObservableCollectionQueryPatternChangedEvent >> sendTo: anObject [

	anObject observableCollectionQueryPatternChangedEvent self
]
