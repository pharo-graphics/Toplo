Class {
	#name : #ToInfiniteElementHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfiniteElementHolder >> data: aData [

	data := aData.
	itemElement := infiniteElement dataToElementFactory value: data	
]
