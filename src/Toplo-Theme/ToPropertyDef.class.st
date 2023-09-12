Class {
	#name : #ToPropertyDef,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToPropertyDef >> name [

	^ name
]

{ #category : #accessing }
ToPropertyDef >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToPropertyDef >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToPropertyDef >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
