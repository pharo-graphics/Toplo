Class {
	#name : #ToObservableCollectionFilterAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern',
		'selectedIndexes'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToObservableCollectionFilterAppliedEvent >> pattern [

	^  pattern ifNil: [ pattern := '' ]
]

{ #category : #accessing }
ToObservableCollectionFilterAppliedEvent >> pattern: aString [

	pattern := aString
]

{ #category : #accessing }
ToObservableCollectionFilterAppliedEvent >> selectedIndexes [

	^ selectedIndexes ifNil: [ selectedIndexes := #(  ) ]
]

{ #category : #accessing }
ToObservableCollectionFilterAppliedEvent >> selectedIndexes: anIntegerCollection [

	selectedIndexes := anIntegerCollection
]

{ #category : #sending }
ToObservableCollectionFilterAppliedEvent >> sendTo: anObject [

	anObject observableCollectionFilterAppliedEvent: self
]
