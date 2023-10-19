Class {
	#name : 'ToIdSelector',
	#superclass : 'ToSimpleSelector',
	#instVars : [
		'id'
	],
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToIdSelector >> accept: aVisitor [

	aVisitor visitIdSelector: self
]

{ #category : 'accessing' }
ToIdSelector >> id [

	^ id
]

{ #category : 'accessing' }
ToIdSelector >> id: aSymbol [

	id := aSymbol
]
