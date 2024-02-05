Class {
	#name : #ToStampSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'stamps'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToStampSelector >> accept: aVisitor [

	aVisitor visitStyleStampSelector: self
]

{ #category : #accessing }
ToStampSelector >> addAllStamps: aCollectionOfSymbols [

	aCollectionOfSymbols do: [ :sy | self addStamp: sy ]
]

{ #category : #accessing }
ToStampSelector >> addStamp: aSymbol [

	(stamps includes: aSymbol) ifTrue: [ ^ self ].
	stamps := stamps copyWith: aSymbol asSymbol
]

{ #category : #accessing }
ToStampSelector >> allStamps [

	^ stamps 
]

{ #category : #converting }
ToStampSelector >> asSourceCode [

	self allStamps size = 1 ifTrue: [ ^ self allStamps first printString , ' asStampSelector' ].
	^ self allStamps printString , ' asStampSelector'
]

{ #category : #converting }
ToStampSelector >> asStampSelector [

	^ self

	
]

{ #category : #initialization }
ToStampSelector >> initialize [ 

	super initialize.
	stamps := #()
]
