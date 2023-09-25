Class {
	#name : #ToStyleTagSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'tags'
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
	tags := Array new
]

{ #category : #accessing }
ToStyleTagSelector >> styleTag: aSymbol [

	self styleTags: { aSymbol }
]

{ #category : #accessing }
ToStyleTagSelector >> styleTags [

	^ tags
]

{ #category : #accessing }
ToStyleTagSelector >> styleTags: aCollectionOfSymbols [

	tags := (tags copyWithAll: (aCollectionOfSymbols asArray collect: [ :s | s asSymbol  ])) asSet asArray
]
