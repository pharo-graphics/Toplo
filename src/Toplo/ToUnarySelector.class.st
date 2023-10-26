Class {
	#name : 'ToUnarySelector',
	#superclass : 'ToElementSelector',
	#instVars : [
		'left'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'accessing' }
ToUnarySelector >> left [

	^ left
]

{ #category : 'accessing' }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
