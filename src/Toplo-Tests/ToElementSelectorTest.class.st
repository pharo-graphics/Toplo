"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : 'ToElementSelectorTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Selector',
	#package : 'Toplo-Tests',
	#tag : 'Core-Selector'
}

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray [

	| selector  |
	selector := #(#'small-sizing' #x) asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector stampNames includesAll: #(#'small-sizing' #x)).

]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray2 [

	| selector |
	selector := { 'small-sizing'. 'x' } asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector stampNames includesAll: #( #'small-sizing' #x ))
]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnArray3 [

	| selector |
	selector := { 'small-sizing'. 'x' } asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector stampNames includesAll: #( #'small-sizing' #x ))
]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnObjectNotImplemented [

	self should: [Object new asElementSelector] raise: MessageNotUnderstood .

]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnSet3 [

	| selector  |
	selector := { 'small-sizing'.  'x' } asSet asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: (selector stampNames includesAll: #(#'small-sizing' #x)).

]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnString [

	| selector  |
	selector := 'small-sizing' asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: selector stampNames equals: #(#'small-sizing').

]

{ #category : 'tests - asToTag' }
ToElementSelectorTest >> testAsStyleSelectorOnSymbol [

	| selector  |
	selector := #'small-sizing' asElementSelector.
	self assert: (selector isKindOf: ToStampSelector).
	self assert: selector stampNames equals: #(#'small-sizing').

]
