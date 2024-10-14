Class {
	#name : #ToStampSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'stamps'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToStampSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self allStamps = anObject allStamps
]

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
ToStampSelector >> asStampSelector [

	^ self

	
]

{ #category : #comparing }
ToStampSelector >> hash [

	^ super hash bitXor: stamps hash
]

{ #category : #initialization }
ToStampSelector >> initialize [ 

	super initialize.
	stamps := #()
]
