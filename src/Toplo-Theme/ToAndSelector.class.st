Class {
	#name : 'ToAndSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
