Class {
	#name : #ToStyleStampSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'stampNames'
	],
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToStyleStampSelector >> accept: aVisitor [

	aVisitor visitStyleStampSelector: self
]

{ #category : #accessing }
ToStyleStampSelector >> addAllStampNames: aCollectionOfSymbols [

	stampNames := (stampNames copyWithAll: (aCollectionOfSymbols asArray collect: [ :s | s asSymbol  ])) asSet asArray
]

{ #category : #accessing }
ToStyleStampSelector >> addStampName: aSymbol [

	self addAllStampNames: { aSymbol }
]

{ #category : #initialization }
ToStyleStampSelector >> initialize [ 

	super initialize.
	stampNames := Array new
]

{ #category : #accessing }
ToStyleStampSelector >> stampNames [

	^ stampNames
]
