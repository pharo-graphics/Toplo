Class {
	#name : #ToChildSelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'parentSelector',
		'parentLevel'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToChildSelector >> accept: aVisitor [

	aVisitor visitChildSelector: self
]

{ #category : #initialization }
ToChildSelector >> initialize [ 

	super initialize.
	parentLevel := 1 
]

{ #category : #accessing }
ToChildSelector >> parent: aSelector [

	Error signal: 'Usage error: I can''t have a child selector'
]

{ #category : #accessing }
ToChildSelector >> parentLevel [

	^ parentLevel
]

{ #category : #accessing }
ToChildSelector >> parentLevel: anInteger [

	parentLevel := anInteger
]

{ #category : #accessing }
ToChildSelector >> parentSelector [

	^ parentSelector
]

{ #category : #accessing }
ToChildSelector >> parentSelector: aSelector [

	parentSelector := aSelector
]
