Class {
	#name : #ToElementAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementAnchor >> element [

	^ element
]

{ #category : #accessing }
ToElementAnchor >> element: anElement [

	element := anElement
]
