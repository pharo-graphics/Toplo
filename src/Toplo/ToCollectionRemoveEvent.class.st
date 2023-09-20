Class {
	#name : 'ToCollectionRemoveEvent',
	#superclass : 'ToCollectionAfterChangeEvent',
	#instVars : [
		'removed'
	],
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 'accessing' }
ToCollectionRemoveEvent >> removed [

	^ removed
]

{ #category : 'accessing' }
ToCollectionRemoveEvent >> removed: aCollection [

	removed := aCollection
]
