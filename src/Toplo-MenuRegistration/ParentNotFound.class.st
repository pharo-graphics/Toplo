"
I'm a simple report element for menu registration. 
"
Class {
	#name : #ParentNotFound,
	#superclass : #ProblemReport,
	#instVars : [
		'itemName'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #accessing }
ParentNotFound >> itemName [
	^ itemName
]

{ #category : #accessing }
ParentNotFound >> itemName: aString [ 
	itemName := aString
]
