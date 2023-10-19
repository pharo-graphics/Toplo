Class {
	#name : 'ToActionSelector',
	#superclass : 'ToSimpleSelector',
	#instVars : [
		'action'
	],
	#category : 'Toplo-Theme-StyleSelector',
	#package : 'Toplo-Theme',
	#tag : 'StyleSelector'
}

{ #category : 'visiting' }
ToActionSelector >> accept: aVisitor [

	aVisitor visitActionSelector: self
]

{ #category : 'accessing' }
ToActionSelector >> action [

	^ action
]

{ #category : 'accessing' }
ToActionSelector >> action: aValuable [
	" aValuable takes one ToElement as argument "
	action := aValuable
]
