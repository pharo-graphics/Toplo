Class {
	#name : #ToElementSelector,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #accessing }
ToElementSelector >> and: aStyleSelector [

	self next: aStyleSelector
]

{ #category : #accessing }
ToElementSelector >> next [

	^ next
]

{ #category : #accessing }
ToElementSelector >> next: aStyleSelector [

	next := aStyleSelector
]

{ #category : #operating }
ToElementSelector >> nextDo: aBlock [

	self next ifNil: [ ^ self ].
	aBlock value: self next
]

{ #category : #accessing }
ToElementSelector >> parent: aSelector [

	self next: (ToChildSelector new
			 parentSelector: aSelector;
			 yourself)
]

{ #category : #accessing }
ToElementSelector >> parent: aSelector level: anInteger [

	self next: (ToChildSelector new
			 parentSelector: aSelector;
			 parentLevel: anInteger;
			 yourself)
]
