Class {
	#name : #MenuRegistrationVisitor,
	#superclass : #Object,
	#instVars : [
		'menuPane'
	],
	#category : #'MenuRegistration-Visitor'
}

{ #category : #accessing }
MenuRegistrationVisitor >> menuPane [

	^ menuPane
]

{ #category : #visiting }
MenuRegistrationVisitor >> visitMenuBuilder: aMenuBuilder [

	self subclassResponsibility.
]

{ #category : #visiting }
MenuRegistrationVisitor >> visitMenuRegistration: aMenuRegistration [

	self subclassResponsibility
]
