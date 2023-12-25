"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : #ToElementSelectorTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Selectors'
}

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray [

	| selector  |
	selector := #(#'small-sizing' #x) asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector allStamps includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray2 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector allStamps includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray3 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector allStamps includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnObjectNotImplemented [

	self should: [Object new asTypeSelector] raise: MessageNotUnderstood .

]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnSet3 [

	| selector  |
	selector := { 'small-sizing'.  'x' } asSet asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector allStamps includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnString [

	| selector  |
	selector := 'small-sizing' asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: selector allStamps asArray equals: #(#'small-sizing').

]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnSymbol [

	| selector  |
	selector := #'small-sizing' asStampSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: selector allStamps asArray equals: #(#'small-sizing').

]

{ #category : #'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnToElement [

	| selector  |
	selector := ToElement asTypeSelector.
	self assert: (selector isKindOf: ToTypeSelector).
	self assert: selector type equals: ToElement.

]
