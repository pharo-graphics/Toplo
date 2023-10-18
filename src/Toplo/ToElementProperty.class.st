Class {
	#name : #ToElementProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #accessing }
ToElementProperty >> name [

	^ name
]

{ #category : #accessing }
ToElementProperty >> name: anObject [

	name := anObject asSymbol
]

{ #category : #operating }
ToElementProperty >> read: anObject [

	self subclassResponsibility 
]
