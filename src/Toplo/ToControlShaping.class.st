Class {
	#name : #ToControlShaping,
	#superclass : #Object,
	#instVars : [
		'sizing'
	],
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #hook }
ToControlShaping >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToControlShaping >> sizing [

	^ sizing
]

{ #category : #accessing }
ToControlShaping >> sizing: anObject [

	sizing := anObject
]
