Class {
	#name : 'ToAbstractProperty',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'accessing' }
ToAbstractProperty >> name [

	^ name
]

{ #category : 'accessing' }
ToAbstractProperty >> name: anObject [

	name := anObject asSymbol
]

{ #category : 'operating' }
ToAbstractProperty >> read: anObject [

	self subclassResponsibility 
]
