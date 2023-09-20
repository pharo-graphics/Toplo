Class {
	#name : 'ToCollectionBeforeAddEvent',
	#superclass : 'ToCollectionBeforeChangeEvent',
	#instVars : [
		'candidates'
	],
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'accessing' }
ToCollectionBeforeAddEvent >> candidates [

	^ candidates
]

{ #category : 'accessing' }
ToCollectionBeforeAddEvent >> candidates: aCollection [

	candidates := aCollection
]
