Class {
	#name : #ToCollectionRemoveChange,
	#superclass : #ToCollectionAfterChange,
	#instVars : [
		'removed'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionRemoveChange >> removed [

	^ removed
]

{ #category : #accessing }
ToCollectionRemoveChange >> removed: aCollection [

	removed := aCollection
]
