Class {
	#name : #MenuRegistrationVisitor,
	#superclass : #Object,
	#instVars : [
		'menuPane'
	],
	#category : #'Toplo-MenuRegistration'
}

{ #category : #accessing }
MenuRegistrationVisitor >> menuPane [

	^ menuPane
]

{ #category : #visiting }
MenuRegistrationVisitor >> visitMenuBuilder: aMenuBuilder [

	self subclassResponsibility
]

{ #category : #visiting }
MenuRegistrationVisitor >> visitMenuRegistration: aMenuRegistration [

	self subclassResponsibility
]
