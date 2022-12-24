Class {
	#name : #ToInfiniteElementHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToInfiniteElementHolder >> data: aData [

	data := aData.
	itemElement := infiniteElement dataToElementStencyl value: data
	
]
