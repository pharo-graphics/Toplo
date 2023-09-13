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

{ #category : #initialization }
ToStyleClassSelector >> initialize [ 

	super initialize.
	elementClasses := OrderedCollection new
]

{ #category : #accessing }
ToStyleClassSelector >> styleClass: aSymbol [

	elementClasses add: aSymbol
]

{ #category : #accessing }
ToStyleClassSelector >> styleClasses [

	^ elementClasses
]

{ #category : #accessing }
ToStyleClassSelector >> styleClasses: aCollectionOfSymbols [

	elementClasses addAll: aCollectionOfSymbols
]
