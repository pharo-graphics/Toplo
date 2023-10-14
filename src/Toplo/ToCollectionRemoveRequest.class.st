Class {
	#name : 'ToCollectionRemoveRequest',
	#superclass : 'ToCollectionChangeRequest',
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'sending' }
ToCollectionRemoveRequest >> sendTo: anObject [

	anObject collectionRemoveRequest: self
]
