Class {
	#name : #ToParentSatisfyingSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'lookupSelector'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #comparing }
ToParentSatisfyingSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ lookupSelector = anObject lookupSelector
]

{ #category : #visiting }
ToParentSatisfyingSelector >> accept: aVisitor [

	aVisitor visitParentSatisfyingSelector: self
]

{ #category : #comparing }
ToParentSatisfyingSelector >> hash [

	^ super hash bitXor: lookupSelector hash
]

{ #category : #initialization }
ToParentSatisfyingSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
	lookupSelector := ToNoneSelector new
]

{ #category : #accessing }
ToParentSatisfyingSelector >> lookupSelector [

	^ lookupSelector
]

{ #category : #accessing }
ToParentSatisfyingSelector >> lookupSelector: aSelector [

	lookupSelector := aSelector
]
