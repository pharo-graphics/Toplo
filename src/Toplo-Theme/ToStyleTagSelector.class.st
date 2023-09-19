Class {
	#name : #ToStyleTagSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'elementClasses'
	],
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToStyleTagSelector >> accept: aVisitor [

	aVisitor visitStyleTagSelector: self
]

{ #category : #initialization }
ToStyleTagSelector >> initialize [ 

	super initialize.
	elementClasses := OrderedCollection new
]

{ #category : #accessing }
ToStyleTagSelector >> styleTag: aSymbol [

	elementClasses add: aSymbol
]

{ #category : #accessing }
ToStyleTagSelector >> styleTags [

	^ elementClasses
]

{ #category : #accessing }
ToStyleTagSelector >> styleTags: aCollectionOfSymbols [

	elementClasses addAll: aCollectionOfSymbols
]
