Class {
	#name : 'ToCollectionAddRequest',
	#superclass : 'ToCollectionChangeRequest',
	#instVars : [
		'candidates'
	],
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'accessing' }
ToCollectionAddRequest >> candidates [

	^ candidates
]

{ #category : 'accessing' }
ToCollectionAddRequest >> candidates: aCollection [

	candidates := aCollection
]

{ #category : 'sending' }
ToCollectionAddRequest >> sendTo: anObject [

	anObject collectionAddRequest: self
]
