"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : #ToStyleSelectorTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSelector'
}

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnArray [

	| selector  |
	selector := #(#'small-sizing' #x)asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnArray2 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnArray3 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnObjectNotImplemented [

	self should: [Object new asStyleSelector] raise: MessageNotUnderstood .

]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnSet3 [

	| selector  |
	selector := { 'small-sizing'.  'x' } asSet asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnString [

	| selector  |
	selector := 'small-sizing' asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: selector styleTags equals: #(#'small-sizing').

]

{ #category : #'tests - asToTag' }
ToStyleSelectorTest >> testAsStyleSelectorOnSymbol [

	| selector  |
	selector := #'small-sizing' asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: selector styleTags equals: #(#'small-sizing').

]
