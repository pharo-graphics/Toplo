Class {
	#name : #ToTypeSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'type',
		'exact'
	],
	#category : #'Toplo-Core-Selector'
}

{ #category : #visiting }
ToTypeSelector >> accept: aVisitor [

	aVisitor visitTypeSelector: self
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

{ #category : #initialization }
ToTypeSelector >> initialize [ 

	super initialize.
	exact := true
]

{ #category : #initialization }
ToTypeSelector >> printOnStyleSheet: aStream [

	aStream nextPutAll: self type asString.
]

{ #category : #operating }
ToTypeSelector >> selectType: aClass [

	^ self exact
		  ifTrue: [ self type == aClass ]
		  ifFalse: [ aClass isKindOf: self type ]
]

{ #category : #accessing }
ToTypeSelector >> type [

	^ type
]

{ #category : #accessing }
ToTypeSelector >> type: aClass [

	type := aClass
]
