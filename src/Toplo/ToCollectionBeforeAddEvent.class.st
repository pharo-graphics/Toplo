Class {
	#name : #ToCollectionBeforeAddEvent,
	#superclass : #ToCollectionBeforeChangeEvent,
	#instVars : [
		'candidates'
	],
	#category : 'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionBeforeAddEvent >> candidates [

	^ candidates
]

{ #category : #accessing }
ToCollectionBeforeAddEvent >> candidates: aCollection [

	candidates := aCollection
]
