Class {
	#name : #ToElementProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #comparing }
ToElementProperty >> isConficting: anotherProperty [

	" two properties with the same name are in conflict  "
	self name = anotherProperty name ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
ToElementProperty >> name [

	^ name
]

{ #category : #accessing }
ToElementProperty >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToElementProperty >> read: anObject [

	self subclassResponsibility 
]

{ #category : #operating }
ToElementProperty >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
