Class {
	#name : #ToObservableCollectionFilterResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'queryRunner'
	],
	#category : #'Toplo-Core-CollectionFilter'
}

{ #category : #accessing }
ToObservableCollectionFilterResultEvent >> filter [

	^ queryRunner
]

{ #category : #accessing }
ToObservableCollectionFilterResultEvent >> filter: aQueryRunner [

	queryRunner := aQueryRunner
]

{ #category : #sending }
ToObservableCollectionFilterResultEvent >> sendTo: anObject [

	anObject observableCollectionFilterResultEvent: self
]
