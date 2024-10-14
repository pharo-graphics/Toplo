Class {
	#name : #ToTypeSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'type',
		'exact'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToTypeSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self type = anObject type and: [ self exact = anObject exact ]
]

{ #category : #visiting }
ToTypeSelector >> accept: aVisitor [

	aVisitor visitTypeSelector: self
]

{ #category : #converting }
ToTypeSelector >> asTypeSelector [

	^ self
]

{ #category : #accessing }
ToTypeSelector >> exact [

	^ exact
]

{ #category : #accessing }
ToTypeSelector >> exact: aBoolean [
	" if true, compare with ==, else, compare with isKindOf: "

	exact := aBoolean
]

{ #category : #comparing }
ToTypeSelector >> hash [

	^ super hash bitXor: type hash
]

{ #category : #initialization }
ToTypeSelector >> initialize [ 

	super initialize.
	exact := true
]

{ #category : #testing }
ToTypeSelector >> isTypeSelector [

	^ true
]

{ #category : #operating }
ToTypeSelector >> selectType: aClass [

	self type == aClass ifTrue:[ ^ true ].
	self exact ifFalse: [ ^ aClass inheritsFrom: self type ].
	^ false
]

{ #category : #accessing }
ToTypeSelector >> type [

	^ type
]

{ #category : #accessing }
ToTypeSelector >> type: aClass [

	type := aClass
]
