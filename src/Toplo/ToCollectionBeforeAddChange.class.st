Class {
	#name : #ToCollectionBeforeAddChange,
	#superclass : #ToCollectionBeforeChange,
	#instVars : [
		'candidates'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionBeforeAddChange >> candidates [

	^ candidates
]

{ #category : #accessing }
ToCollectionBeforeAddChange >> candidates: aCollection [

	candidates := aCollection
]
