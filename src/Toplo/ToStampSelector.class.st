Class {
	#name : #ToStampSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'stampNames'
	],
	#category : 'Toplo-Core-Selector'
}

{ #category : #visiting }
ToStampSelector >> accept: aVisitor [

	aVisitor visitStyleStampSelector: self
]

{ #category : #accessing }
ToStampSelector >> addAllStampNames: aCollectionOfSymbols [

	stampNames := (stampNames copyWithAll: (aCollectionOfSymbols asArray collect: [ :s | s asSymbol  ])) asSet asArray
]

{ #category : #accessing }
ToStampSelector >> addStampName: aSymbol [

	self addAllStampNames: { aSymbol }
]

{ #category : #initialization }
ToStampSelector >> initialize [ 

	super initialize.
	stampNames := Array new
]

{ #category : #accessing }
ToStampSelector >> stampNames [

	^ stampNames
]
