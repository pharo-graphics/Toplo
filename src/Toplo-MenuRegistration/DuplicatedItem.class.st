"
I'm a simple report element for menu registration. 
"
Class {
	#name : #DuplicatedItem,
	#superclass : #ProblemReport,
	#instVars : [
		'itemName'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'item management' }
DuplicatedItem >> itemNamed: aString [ 
	itemName := aString
]
