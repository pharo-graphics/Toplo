Class {
	#name : 'ToTypeSelector',
	#superclass : 'ToSimpleSelector',
	#instVars : [
		'type',
		'exact'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToTypeSelector >> accept: aVisitor [

	aVisitor visitTypeSelector: self
]

{ #category : 'accessing' }
ToTypeSelector >> exact [

	^ exact
]

{ #category : 'accessing' }
ToTypeSelector >> exact: aBoolean [
	" if true, compare with ==, else, compare with isKindOf: "

	exact := aBoolean
]

{ #category : 'initialization' }
ToTypeSelector >> initialize [ 

	super initialize.
	exact := true
]

{ #category : 'operating' }
ToTypeSelector >> selectType: aClass [

	self type == aClass ifTrue:[ ^ true ].
	self exact ifFalse: [ ^ aClass inheritsFrom: self type ].
	^ false
]

{ #category : 'accessing' }
ToTypeSelector >> type [

	^ type
]

{ #category : 'accessing' }
ToTypeSelector >> type: aClass [

	type := aClass
]
