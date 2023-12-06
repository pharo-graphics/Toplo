Class {
	#name : 'ToActionSelector',
	#superclass : 'ToSimpleSelector',
	#instVars : [
		'action'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
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
	" aValuable takes one element as argument "
	action := aValuable
]
