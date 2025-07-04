Class {
	#name : #DuplicatedItem,
	#superclass : #Object,
	#instVars : [
		'itemName'
	],
	#category : #'Toplo-MenuRegistration-NewCreate'
}

{ #category : #'item management' }
DuplicatedItem >> itemNamed: aString [ 
	itemName := aString
]
