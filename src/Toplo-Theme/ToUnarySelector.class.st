Class {
	#name : #ToUnarySelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'left'
	],
	#category : #'Toplo-Theme-StyleOperator'
}

{ #category : #accessing }
ToUnarySelector >> left [

	^ left
]

{ #category : #accessing }
ToUnarySelector >> left: aSelector [

	left := aSelector
]
