Class {
	#name : #ToPropertyDefinition,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToPropertyDefinition >> name [

	^ name
]

{ #category : #accessing }
ToPropertyDefinition >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToPropertyDefinition >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToPropertyDefinition >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
