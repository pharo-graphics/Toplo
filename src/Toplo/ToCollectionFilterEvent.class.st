Class {
	#name : 'ToCollectionFilterEvent',
	#superclass : 'ToCollectionAfterChangeEvent',
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'sending' }
ToCollectionFilterEvent >> sendTo: anObject [

	anObject collectionFilterEvent: self
]
