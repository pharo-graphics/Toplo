Class {
	#name : #ToAbstractProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToAbstractProperty >> name [

	^ name
]

{ #category : #accessing }
ToAbstractProperty >> name: anObject [

	name := anObject asSymbol
]

{ #category : #printing }
ToAbstractProperty >> printOn: aStream [

	super printOn: aStream.
	aStream << ' [' << (self name ifNil: [ '<invalid anonymous property>' ]) << ']'
]

{ #category : #operating }
ToAbstractProperty >> read: anObject [

	self subclassResponsibility 
]
