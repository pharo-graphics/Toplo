"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : #ToStyleSelectorInterpreterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSelector'
}

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnArray [

	| selector  |
	selector := #(#'small-sizing' #x)asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnArray2 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnArray3 [

	| selector |
	selector := { 'small-sizing'. 'x' } asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #( #'small-sizing' #x ))
]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnObjectNotImplemented [

	self should: [Object new asStyleSelector] raise: MessageNotUnderstood .

]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnSet3 [

	| selector  |
	selector := { 'small-sizing'.  'x' } asSet asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: (selector styleTags includesAll: #(#'small-sizing' #x)).

]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnString [

	| selector  |
	selector := 'small-sizing' asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: selector styleTags equals: #(#'small-sizing').

]

{ #category : #'tests - asToTag' }
ToStyleSelectorInterpreterTest >> testAsToTagOnSymbol [

	| selector  |
	selector := #'small-sizing' asStyleSelector.
	self assert: (selector isKindOf: ToStyleTagSelector).
	self assert: selector styleTags equals: #(#'small-sizing').

]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithElementWithAParent0 [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToChildSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	" ko, the element e has a parent which is a ToElement, not an Object "
	self assert: engine result not.
	selector right exact: false.
	engine check: selector on: e.
	" ok, the element e has a parent which is a kind of Object "
	self assert: engine result
	


	
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithElementWithAParent1 [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToUniversalSelector new parent: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToStyleSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: e.
	self assert: engine result.
	
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithElementWithAParent2 [

	| engine parent directParentSelector1 directParentSelector2 parentParentSelector sub subsub |
	directParentSelector1 := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement).
	directParentSelector2 := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement) level: 1.
	parentParentSelector := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement) level: 2.
	sub := ToElement new.
	subsub := ToElement new.
	parent := ToElement new.
	parent addChild: subsub.
	subsub addChild: sub.
	self assert: subsub parent == parent.
	engine := ToStyleSelectorInterpreter new.
	engine check: directParentSelector1 on: subsub.
	self assert: engine result.
	engine check: directParentSelector2 on: subsub.
	self assert: engine result.
	engine check: parentParentSelector on: subsub
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithElementWithNoParent [

	| selector e engine |
	selector := ToChildSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass0 [

	" element with no class, selector without class "

	| selector e engine |
	selector := ToStyleTagSelector new.
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass1 [

	" element with a class, selector without class "

	| selector e engine |
	selector := ToStyleTagSelector new.
	e := ToElement new addStyleTag: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass2 [

	" element with a class, selector with the same class "

	| selector e engine |
	selector := ToStyleTagSelector new styleTag: #a.
	e := ToElement new addStyleTag: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass3 [

	" element with a class, selector with the a different class "

	| selector e engine |
	selector := ToStyleTagSelector new styleTag: #b.
	e := ToElement new addStyleTag: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	selector := ToStyleTagSelector new styleTags: #(#b).
	e := ToElement new addStyleTag: #a.
	self assert: engine result not.


]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass4 [
	" element with multiple classes "

	| selector e engine |
	selector := ToStyleTagSelector new styleTags: #( #a ).
	e := ToElement new addStyleTag: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e addStyleTag: #c.
	self assert: engine result.
	engine check: selector on: e.
	self assert: engine result.
	e addStyleTag: #b.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testNotSelector [

	| selector e engine |
	engine := ToStyleSelectorInterpreter new.
	selector := ToTypeSelector new type: ToElement.
	e := ToElement new.
	engine check: selector on: e.
	self assert: engine result.
	
	selector := (ToTypeSelector new type: ToElement) not.
	engine check: selector on: e.
	self assert: engine result not.


]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStyleTagSelector new styleTags: #( #button ))
	            + (ToStyleTagSelector new styleTags: #( #danger )).

	e := ToElement new styleTag: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e addStyleTag: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result.

	selector := selector not.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndWithChildSelector [
	" a rule with an And operator  "

	| selector e engine child |
	selector := (ToStyleTagSelector new styleTag: #'button-label')
		            parent:
			            (ToStyleTagSelector new styleTags: #( #button ))
			            + (ToStyleTagSelector new styleTags: #( #danger ))
		            level: 1.

	e := ToElement new styleTag: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e addStyleTag: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.
	e addChild: (child := ToElement new styleTag: #'button-label').
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.

	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testRuleWithOrSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStyleTagSelector new styleTags: #( #button ))
		            or: (ToStyleTagSelector new styleTags: #( #button #horizontal )).

	e := ToElement new styleTag: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e addStyleTag: #horizontal.
	engine check: selector on: e.
	self assert: engine result.
	e styleTags: { #blob }.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testRuleWithOrWithChildSelector [
	" a rule with an Or operator with a child selector  "

	| selector e engine child |
	selector := (ToStyleTagSelector new styleTag: #'inner-element')
		            parent: ((ToStyleTagSelector new styleTags:
				              #( #button #horizontal #justified )) or:
				             (ToStyleTagSelector new styleTags:
					              #( #button #justified )))
		            level: 1.

	e := ToElement new styleTag: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.

	e addChild: (child := ToElement new styleTag: #'inner-element').
	engine check: selector on: child.
	self assert: engine result not.

	e addStyleTag: #justified.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testTypeSelector [

	| selector e engine |
	selector := ToTypeSelector new type: ToElement.
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testUniversalSelector [

	| selector e engine |
	selector := ToUniversalSelector new.
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testUniversalSelectorWithParent [

	| selector button engine chilLevel3 |	
	selector := ToUniversalSelector new parent: (ToStyleTagSelector new styleTags: #( #button #circle ) ) level: 2.	
	button := ToElement new id: #button.
	button styleTags: #(#button #circle).
	button addChild: (ToElement new  id: #inner).
	button firstChild addChild: (chilLevel3 := ToElement new).
	chilLevel3 id: #childLevel3.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: chilLevel3.
	self assert: engine result 
]
