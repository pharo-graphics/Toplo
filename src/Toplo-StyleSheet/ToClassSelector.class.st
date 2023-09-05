Class {
	#name : #ToClassSelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'elementClasses'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #visiting }
ToClassSelector >> accept: aVisitor [

	aVisitor visitClassSelector: self
]

{ #category : #accessing }
ToClassSelector >> elementClass: aSymbol [

	elementClasses add: aSymbol
]

{ #category : #accessing }
ToClassSelector >> elementClasses [

	^ elementClasses
]

{ #category : #accessing }
ToClassSelector >> elementClasses: aCollectionOfSymbols [

	elementClasses addAll: aCollectionOfSymbols
]

{ #category : #initialization }
ToClassSelector >> initialize [ 

	super initialize.
	elementClasses := OrderedCollection new
]
