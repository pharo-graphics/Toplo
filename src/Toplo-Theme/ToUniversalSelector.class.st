Class {
	#name : 'ToUniversalSelector',
	#superclass : 'ToSimpleSelector',
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
