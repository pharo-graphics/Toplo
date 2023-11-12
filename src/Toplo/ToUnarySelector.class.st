Class {
	#name : #ToUnarySelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'left'
	],
	#category : 'Toplo-Core-Selector'
}

{ #category : #accessing }
ToUnarySelector >> left [

	^ left
]

{ #category : #accessing }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
