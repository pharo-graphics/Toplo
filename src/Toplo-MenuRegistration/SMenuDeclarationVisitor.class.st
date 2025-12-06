Class {
	#name : #SMenuDeclarationVisitor,
	#superclass : #Object,
	#instVars : [
		'menuPane'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #accessing }
SMenuDeclarationVisitor >> menuPane [

	^ menuPane
]

{ #category : #visiting }
SMenuDeclarationVisitor >> visitMenuBuilder: aMenuBuilder [

	self subclassResponsibility
]

{ #category : #visiting }
SMenuDeclarationVisitor >> visitMenuRegistration: aMenuRegistration [

	self subclassResponsibility
]
