Class {
	#name : #ToObservableCollectionFilterApplierEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern',
		'selectedIndexes'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToObservableCollectionFilterApplierEvent >> pattern [

	^  pattern ifNil: [ pattern := '' ]
]

{ #category : #accessing }
ToObservableCollectionFilterApplierEvent >> pattern: aString [

	pattern := aString
]

{ #category : #accessing }
ToObservableCollectionFilterApplierEvent >> selectedIndexes [

	^ selectedIndexes ifNil: [ selectedIndexes := #(  ) ]
]

{ #category : #accessing }
ToObservableCollectionFilterApplierEvent >> selectedIndexes: anIntegerCollection [

	selectedIndexes := anIntegerCollection
]

{ #category : #sending }
ToObservableCollectionFilterApplierEvent >> sendTo: anObject [

	anObject observableCollectionFilterAppliedEvent: self
]
