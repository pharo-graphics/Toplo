"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : #ToElementSelectorTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Selectors'
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

{ #category : #tests }
ToElementSelectorTest >> testEquals1 [

	| selector1 selector2 |
	selector1 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	selector2 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals10 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new && ToUniversalSelector new.
	selector2 := ToUniversalSelector new && ToUniversalSelector new.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals11 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new withChild: ToUniversalSelector new.
	selector2 := ToUniversalSelector new withChild: ToUniversalSelector new.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals12 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new withChild:
		             ToUniversalSelector new atDepth: 2.
	selector2 := ToUniversalSelector new withChild:
		             ToUniversalSelector new atDepth: 2.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals13 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new
		             withParent: ToUniversalSelector new
		             .
	selector2 := ToUniversalSelector new
		             withParent: ToUniversalSelector new
		             .
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals14 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new
		             withParent: ToUniversalSelector new
		             atDepth: 2.
	selector2 := ToUniversalSelector new
		             withParent: ToUniversalSelector new
		             atDepth: 2.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals15 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new withSibling:
		             ToUniversalSelector new.
	selector2 := ToUniversalSelector new withSibling:
		             ToUniversalSelector new.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals16 [

	| selector1 selector2 |
	selector1 := #(#titi #toto) asStampSelector.
	selector2 := #(#titi #toto) asStampSelector.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals17 [

	| selector1 selector2 |
	selector1 := ToButton asTypeSelector exact: true.
	selector2 := ToButton asTypeSelector exact: true.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals18 [

	| selector1 selector2 |
	selector1 := ToButton asTypeSelector exact: false.
	selector2 := ToButton asTypeSelector exact: false.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals19 [

	| selector1 selector2 |
	selector1 := [ :e |  ] asActionSelector.
	selector2 := [ :e |  ] asActionSelector.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals2 [

	| selector1 selector2 |
	selector1 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	selector2 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 #stamp4 )
				                asStampSelector) || ToButton asTypeSelector
		               withChild:
			               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
			               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals20 [

	| selector1 selector2 |
	selector1 := [ :e | e isKindOf: ToButton ] asActionSelector.
	selector2 := [ :e | e isKindOf: ToButton ] asActionSelector.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals3 [

	| selector1 selector2 |
	selector1 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToElement asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	selector2 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals4 [

	| selector1 selector2 |
	selector1 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	selector2 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#tutu asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals5 [

	| selector1 selector2 |
	selector1 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 2) not.
	selector2 := (((ToUniversalSelector new withParent:
		                #parent asStampSelector not)
	               && (#test asIdSelector withSibling:
			                #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	               || ToButton asTypeSelector withChild:
		               (#toto asStampSelector withChild: #titi asStampSelector atDepth: 5)
		               && (ToButton asTypeSelector exact: false))
		              withParent: #hello asStampSelector
		              atDepth: 4) not.
	self deny: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals6 [

	| selector1 selector2 |
	selector1 := ToButton asTypeSelector.
	selector2 := ToButton asTypeSelector.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals7 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new.
	selector2 := ToUniversalSelector new.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals8 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new not.
	selector2 := ToUniversalSelector new not.
	self assert: selector1 equals: selector2
]

{ #category : #tests }
ToElementSelectorTest >> testEquals9 [

	| selector1 selector2 |
	selector1 := ToUniversalSelector new || ToUniversalSelector new.
	selector2 := ToUniversalSelector new || ToUniversalSelector new.
	self assert: selector1 equals: selector2
]
