Class {
	#name : #ToUnarySelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'left'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #comparing }
ToUnarySelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self left = anObject left
]

{ #category : #comparing }
ToUnarySelector >> hash [

	^ super hash bitXor: left hash
]

{ #category : #accessing }
ToUnarySelector >> left [

	^ left
]

{ #category : #accessing }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
