Class {
	#name : 'ToCollectionChangeRequest',
	#superclass : 'ToCollectionChangedEvent',
	#instVars : [
		'validated'
	],
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'accessing' }
ToCollectionChangeRequest >> validated [

	^ validated ifNil: [ validated := true ]
]

{ #category : 'accessing' }
ToCollectionChangeRequest >> validated: anObject [

	validated := anObject
]
