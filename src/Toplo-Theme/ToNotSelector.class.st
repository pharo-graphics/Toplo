Class {
	#name : 'ToNotSelector',
	#superclass : 'ToUnarySelector',
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]
