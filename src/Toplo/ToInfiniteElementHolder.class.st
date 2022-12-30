Class {
	#name : #ToInfiniteElementHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'data',
		'dataToElementFactory'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfiniteElementHolder >> data: aData [

	data := aData.
	itemElement := self dataToElementFactory value: data	
]

{ #category : #accessing }
ToInfiniteElementHolder >> dataToElementFactory [

	^ dataToElementFactory
]

{ #category : #accessing }
ToInfiniteElementHolder >> dataToElementFactory: aBlock [

	dataToElementFactory := aBlock
]

{ #category : #initialization }
ToInfiniteElementHolder >> initialize [

	super initialize.
	dataToElementFactory := [ :d | d asElement ]
]
