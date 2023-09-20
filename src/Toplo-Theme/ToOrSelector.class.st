Class {
	#name : 'ToOrSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
