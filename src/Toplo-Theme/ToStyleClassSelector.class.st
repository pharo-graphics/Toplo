Class {
	#name : #ToStyleClassSelector,
	#superclass : #ToUnarySelector,
	#instVars : [
		'elementClasses'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToStyleClassSelector >> accept: aVisitor [

	aVisitor visitStyleClassSelector: self
]

{ #category : #accessing }
ToStyleClassSelector >> elementClass: aSymbol [

	elementClasses add: aSymbol
]

{ #category : #initialization }
ToStyleClassSelector >> initialize [ 

	super initialize.
	elementClasses := OrderedCollection new
]

{ #category : #accessing }
ToStyleClassSelector >> styleClasses [

	^ elementClasses
]

{ #category : #accessing }
ToStyleClassSelector >> styleClasses: aCollectionOfSymbols [

	elementClasses addAll: aCollectionOfSymbols
]
