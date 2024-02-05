Class {
	#name : #ToUnarySelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'left'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToUnarySelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self left = anObject left
]

{ #category : #accessing }
ToUnarySelector >> left [

	^ left
]

{ #category : #accessing }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
