Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ self listElement groupSelectionModel containsIndex:
		  self originalPosition
]

{ #category : #testing }
ToSelectListNodeHolder >> originalPosition [

	| sieve |
	sieve := select sieve.
	^ sieve dataPositionIndex at: self dataItem
]

{ #category : #accessing }
ToSelectListNodeHolder >> select: anObject [

	select := anObject
]
