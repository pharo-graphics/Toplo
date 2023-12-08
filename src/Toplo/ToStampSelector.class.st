Class {
	#name : 'ToStampSelector',
	#superclass : 'ToSimpleSelector',
	#instVars : [
		'stampSet'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToStampSelector >> accept: aVisitor [

	aVisitor visitStyleStampSelector: self
]

{ #category : 'accessing' }
ToStampSelector >> addAllStamps: aCollectionOfSymbols [

	stampSet addAll: (aCollectionOfSymbols collect: [ :s | s asSymbol ])
]

{ #category : 'accessing' }
ToStampSelector >> addStamp: aSymbol [

	stampSet add: aSymbol asSymbol
]

{ #category : 'accessing' }
ToStampSelector >> allStamps [

	^ stampSet 
]

{ #category : 'converting' }
ToStampSelector >> asStampSelector [

	^ self

	
]

{ #category : 'initialization' }
ToStampSelector >> initialize [ 

	super initialize.
	stampSet := IdentitySet new
]
