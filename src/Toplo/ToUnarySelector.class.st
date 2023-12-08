Class {
	#name : 'ToUnarySelector',
	#superclass : 'ToElementSelector',
	#instVars : [
		'left'
	],
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'accessing' }
ToUnarySelector >> left [

	^ left
]

{ #category : 'accessing' }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
