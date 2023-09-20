Class {
	#name : 'ToChildSelector',
	#superclass : 'ToBinarySelector',
	#instVars : [
		'parentLevel'
	],
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToChildSelector >> accept: aVisitor [

	aVisitor visitChildSelector: self
]

{ #category : 'initialization' }
ToChildSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
	parentLevel := 1 
]

{ #category : 'accessing' }
ToChildSelector >> parentLevel [

	^ parentLevel
]

{ #category : 'accessing' }
ToChildSelector >> parentLevel: anInteger [

	parentLevel := anInteger
]
