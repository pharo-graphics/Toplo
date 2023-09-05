Class {
	#name : #ToChildSelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'parentSelector'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #visiting }
ToChildSelector >> accept: aVisitor [

	aVisitor visitChildSelector: self
]

{ #category : #accessing }
ToChildSelector >> parent: aSelector [

	Error signal: 'Usage error: I can''t have a child selector'
]

{ #category : #accessing }
ToChildSelector >> parentSelector [

	^ parentSelector
]

{ #category : #accessing }
ToChildSelector >> parentSelector: aSelector [

	parentSelector := aSelector
]
