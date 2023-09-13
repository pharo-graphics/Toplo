Class {
	#name : #ToLookProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToLookProperty >> name [

	^ name
]

{ #category : #accessing }
ToLookProperty >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToLookProperty >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToLookProperty >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
