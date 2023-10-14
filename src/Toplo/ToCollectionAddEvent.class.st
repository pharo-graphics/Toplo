Class {
	#name : 'ToCollectionAddEvent',
	#superclass : 'ToCollectionAfterChangeEvent',
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'sending' }
ToCollectionAddEvent >> sendTo: anObject [

	anObject collectionAddEvent: self
]
