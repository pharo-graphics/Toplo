"
A ToStyleSelectorEngineTest is a test class for testing the behavior of ToStyleSelectorEngine
"
Class {
	#name : #ToStyleSelectorInterpreterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

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
	selector := ToStyleClassSelector new.
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass1 [

	" element with a class, selector without class "

	| selector e engine |
	selector := ToStyleClassSelector new.
	e := ToElement new addStyleClass: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass2 [

	" element with a class, selector with the same class "

	| selector e engine |
	selector := ToStyleClassSelector new styleClass: #a.
	e := ToElement new addStyleClass: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass3 [

	" element with a class, selector with the a different class "

	| selector e engine |
	selector := ToStyleClassSelector new styleClass: #b.
	e := ToElement new addStyleClass: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	selector := ToStyleClassSelector new styleClasses: #(#b).
	e := ToElement new addStyleClass: #a.
	self assert: engine result not.


]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass4 [
	" element with multiple classes "

	| selector e engine |
	selector := ToStyleClassSelector new styleClasses: #( #a ).
	e := ToElement new addStyleClass: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e addStyleClass: #c.
	self assert: engine result.
	engine check: selector on: e.
	self assert: engine result.
	e addStyleClass: #b.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndWithChildSelector [
	" a rule with an And operator  "
	| selector e engine child |
	selector :=  (ToStyleClassSelector new styleClass: #'button-label') 
				parent: (((ToStyleClassSelector new styleClasses: #( #button )) and: (ToStyleClassSelector new styleClasses: #( #danger )))) level: 1.

	e := ToElement new styleClass: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e addStyleClass: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.
	e addChild: (child := ToElement new styleClass: #'button-label').
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.

	engine check: selector on: child.
	self assert: engine result.


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
