Class {
	#name : 'ToCollectionUpdateEvent',
	#superclass : 'ToCollectionAfterChangeEvent',
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'sending' }
ToCollectionUpdateEvent >> sendTo: anObject [

	anObject collectionUpdateEvent: self
]
