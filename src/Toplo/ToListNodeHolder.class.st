Class {
	#name : #ToListNodeHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListNodeHolder >> data: aData [

	data := aData.
	itemElement := infiniteElement nodeFactory value: aData
]
