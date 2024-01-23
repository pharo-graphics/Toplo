Class {
	#name : #ToObservableCollectionQueryEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selector'
	],
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #accessing }
ToObservableCollectionQueryEvent >> selector [

	^ selector
]

{ #category : #accessing }
ToObservableCollectionQueryEvent >> selector: aSelector [

	selector := aSelector
]
