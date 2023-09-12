Class {
	#name : #ToPropertyType,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToPropertyType >> name [

	^ name
]

{ #category : #accessing }
ToPropertyType >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToPropertyType >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToPropertyType >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
