Class {
	#name : #DuplicatedItem,
	#superclass : #Object,
	#instVars : [
		'itemName'
	],
	#category : #'Toplo-MenuRegistration-Report'
}

{ #category : #'item management' }
DuplicatedItem >> itemNamed: aString [ 
	itemName := aString
]
