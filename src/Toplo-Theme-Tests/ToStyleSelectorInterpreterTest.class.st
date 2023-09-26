"
A ToStyleSelectorInterpreterTest is a test class for testing the behavior of ToStyleSelectorInterpreter
"
Class {
	#name : #ToStyleSelectorInterpreterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSelector'
}

{ #category : #'tests - action selector' }
ToStyleSelectorInterpreterTest >> testActionSelector [

	| selector e engine  |
	e := ToElement new.
	selector := ToActionSelector new action: [:target | target == e].
	engine := ToStyleSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result.

]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildMixedWithParentSelector [

	| button innerElement icon label engine innerElementSelector buttonSelector |
	buttonSelector := (#button  asStyleSelector
		                   child: #'button-label'
		                   depth: 2) "child: #'button-icon' depth: 2".
	innerElementSelector := #'inner-element' asStyleSelector parent:
		                        buttonSelector.

	button := ToElement new.
	button stampWithAll: #( #button ).
	innerElement := ToElement new.
	innerElement stampWith: #'inner-element'.
	icon := ToElement new.
	icon stampWith: #'button-icon'.
	label := ToElement new.
	label stampWith: #'button-label'.

	button addChild: innerElement.
	innerElement addChild: icon.
	innerElement addChild: label.

	engine := ToStyleSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.

	engine check: innerElementSelector on: innerElement.
	self assert: engine result
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelector [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToUniversalSelector new child: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToStyleSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: parent.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: parent.
	self assert: engine result.
	
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithDepth [

	| childSelectorAnyDepth childSelectorDepth1 childSelectorDepth2 sub subsub parent engine |
	
	childSelectorAnyDepth := ToUniversalSelector new child: (ToTypeSelector new type: ToElement).
	childSelectorDepth1 := ToUniversalSelector new child: (ToTypeSelector new type: ToElement) depth: 1.
	childSelectorDepth2 := ToUniversalSelector new child: (ToTypeSelector new type: ToElement) depth: 2.
	
	sub := ToElement new.
	subsub := ToElement new.
	parent := ToElement new.
	parent addChild: sub.
	sub addChild: subsub.
	self assert: sub parent identicalTo: parent.
	self assert: subsub parent identicalTo: sub.

	engine := ToStyleSelectorInterpreter new.

	engine check: childSelectorAnyDepth on: parent.
	self assert: engine result.
	engine check: childSelectorAnyDepth on: sub.
	self assert: engine result.
	engine check: childSelectorAnyDepth on: subsub.
	self assert: engine result not.

	engine check: childSelectorDepth1 on: parent.
	self assert: engine result.
	engine check: childSelectorDepth1 on: sub.
	self assert: engine result.
	engine check: childSelectorDepth1 on: subsub.
	self assert: engine result not.

	engine check: childSelectorDepth2 on: parent.
	self assert: engine result.
	engine check: childSelectorDepth2 on: sub.
	self assert: engine result not.
	engine check: childSelectorDepth2 on: subsub.
	self assert: engine result not
]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithTwoChildrenDepth1 [

	| button icon label engine buttonSelector |
	buttonSelector := ((ToStyleStampSelector new addStampName: #button) child: #'button-label' ).

	button := ToElement new.
	button stampWithAll: #( #button ).
	icon := ToElement new.
	icon stampWith: #'button-icon'.
	label := ToElement new.
	label stampWith: #'button-label'.

	button addChild: icon.
	button addChild: label.

	engine := ToStyleSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.

]

{ #category : #'tests - child selector' }
ToStyleSelectorInterpreterTest >> testChildSelectorWithTwoChildrenWithTwoChildSelectorsDepth2 [

	| button innerElement icon label engine buttonSelector |
	buttonSelector := ((ToStyleStampSelector new addStampName: #button) child: #'button-label' depth: 2) child: #'button-icon' depth: 2.

	button := ToElement new id: #button.
	button stampWithAll: #( #button ).
	innerElement := ToElement new id: #innerElement.
	innerElement stampWith: #'inner-element'.
	icon := ToElement new id: #icon.
	icon stampWith: #'button-icon'.
	label := ToElement new id: #label.
	label stampWith: #'button-label'.

	button addChild: innerElement.
	innerElement addChild: icon.
	innerElement addChild: label.

	engine := ToStyleSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.
	
	button removeChild: innerElement.
	engine check: buttonSelector on: button.
	self assert: engine result not.
	
	button addChild: innerElement.
	innerElement removeChild: icon.
	engine check: buttonSelector on: button.
	self assert: engine result not.
	
	innerElement addChild: icon.
	innerElement removeChild: label.
	engine check: buttonSelector on: button.
	self assert: engine result not.

	

]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass0 [

	" element with no class, selector without class "

	| selector e engine |
	selector := ToStyleStampSelector new.
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass1 [

	" element with a class, selector without class "

	| selector e engine |
	selector := ToStyleStampSelector new.
	e := ToElement new stampWith: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass2 [

	" element with a class, selector with the same class "

	| selector e engine |
	selector := ToStyleStampSelector new addStampName: #a.
	e := ToElement new stampWith: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass3 [

	" element with a class, selector with the a different class "

	| selector e engine |
	selector := ToStyleStampSelector new addStampName: #b.
	e := ToElement new stampWith: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	selector := ToStyleStampSelector new addStampName: #b.
	e := ToElement new stampWith: #a.
	self assert: engine result not.


]

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass4 [
	" element with multiple classes "

	| selector e engine |
	selector := ToStyleStampSelector new addStampName: #a.
	e := ToElement new stampWith: #a.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e stampWith: #c.
	self assert: engine result.
	engine check: selector on: e.
	self assert: engine result.
	e stampWith: #b.
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

{ #category : #'tests - parent selector' }
ToStyleSelectorInterpreterTest >> testParentSelector [

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

{ #category : #'tests - with single selector' }
ToStyleSelectorInterpreterTest >> testParentSelectorWithElementWithNoParent [

	| selector e engine |
	selector := ToParentSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - parent selector' }
ToStyleSelectorInterpreterTest >> testParentSelectorWithoutLeft [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToParentSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToStyleSelectorInterpreter new.
	selector right exact: false.
	engine check: selector on: e.
	" ok, the element e has a parent which is a kind of Object "
	self assert: engine result
	


	
]

{ #category : #'tests - and selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStyleStampSelector new addAllStampNames: #( #button ))
	            + (ToStyleStampSelector new addAllStampNames: #( #danger )).

	e := ToElement new stampWith: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e stampWith: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result.

	selector := selector not.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndSiblingSelector [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := (ToStyleStampSelector new addStampName: #child ) sibling: #sibling.

	parent := ToElement new.
	child := ToElement new stampWith: #child.
	sibling := ToElement new stampWith: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndSiblingSelector2 [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := ((ToStyleStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #sibling.

	parent := ToElement new .
	child := ToElement new stampWith: #child.
	sibling := ToElement new stampWith: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent stampWith: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndSiblingSelector3 [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := ((ToStyleStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #sibling.

	parent := ToElement new .
	child := ToElement new stampWith: #child.
	sibling := ToElement new stampWithAll: #(#image #sibling).
	parent addChild: child.
	parent addChild: sibling.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent stampWith: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector [
	" a rule with an And operator  "

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStyleStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #'image-sibling') sibling: #'label-sibling'.

	parent := ToElement new .
	child := ToElement new stampWith: #child.
	sibling1 := ToElement new stampWithAll: #(#image #'image-sibling').
	sibling2 := ToElement new stampWithAll: #(#label #'label-sibling').
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.
	
	parent stampWith: #parent.
	
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector2 [
	" a rule with an And operator  "

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStyleStampSelector new addStampName: #child) parent:
		              #( #parent )) sibling: #( #image #'image-sibling' ))
		            sibling: #( #label #'label-sibling' ).

	parent := ToElement new.
	child := ToElement new stampWith: #child.
	sibling1 := ToElement new stampWithAll: #( #image #'image-sibling' ).
	sibling2 := ToElement new stampWithAll: #( #label #'label-sibling' ).
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.

	parent stampWith: #parent.

	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - sibling selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector3 [
	" a rule with an And operator  "

	| selector engine parent inner child sibling1 sibling2 |
	selector := (((ToStyleStampSelector new addStampName: #child) 
						parent: #( #parent ) depth: 2) 
							sibling: #( #image #'image-sibling' ))
		     			       sibling: #( #label #'label-sibling' ).

	parent := ToElement new.
	inner := ToElement new.
	child := ToElement new stampWith: #child.
	sibling1 := ToElement new stampWithAll: #( #image #'image-sibling' ).
	sibling2 := ToElement new stampWithAll: #( #label #'label-sibling' ).
	parent addChild: inner.
	inner addChild: sibling1.
	inner addChild: child.
	inner addChild: sibling2.

	parent stampWith: #parent.

	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - and selector' }
ToStyleSelectorInterpreterTest >> testRuleWithAndWithParentSelector [
	" a rule with an And operator  "

	| selector e engine child |
	selector := (ToStyleStampSelector new addStampName: #'button-label')
		            parent:
			            (ToStyleStampSelector new addStampName: #button)
			            + (ToStyleStampSelector new addStampName: #danger )
		            depth: 1.

	e := ToElement new stampWith: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e stampWith: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.
	e addChild: (child := ToElement new stampWith: #'button-label').
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.

	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - or selector' }
ToStyleSelectorInterpreterTest >> testRuleWithOrSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStyleStampSelector new addStampName: #button)
		            or: (ToStyleStampSelector new addAllStampNames: #( #button #horizontal )).

	e := ToElement new stampWith: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e stampWith: #horizontal.
	engine check: selector on: e.
	self assert: engine result.
	e stampWithAll: { #blob }.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - or selector' }
ToStyleSelectorInterpreterTest >> testRuleWithOrWithParentSelector [
	" a rule with an Or operator with a child selector  "

	| selector e engine child |
	selector := (ToStyleStampSelector new addStampName: #'inner-element')
		            parent: ((ToStyleStampSelector new addAllStampNames:
				              #( #button #horizontal #justified )) or:
				             (ToStyleStampSelector new addAllStampNames:
					              #( #button #justified )))
		            depth: 1.

	e := ToElement new stampWith: #button.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.

	e addChild: (child := ToElement new stampWith: #'inner-element').
	engine check: selector on: child.
	self assert: engine result not.

	e stampWith: #justified.
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
	selector := ToUniversalSelector new parent: (ToStyleStampSelector new addAllStampNames: #( #button #circle ) ) depth: 2.	
	button := ToElement new id: #button.
	button stampWithAll: #(#button #circle).
	button addChild: (ToElement new  id: #inner).
	button firstChild addChild: (chilLevel3 := ToElement new).
	chilLevel3 id: #childLevel3.
	engine := ToStyleSelectorInterpreter new.
	engine check: selector on: chilLevel3.
	self assert: engine result 
]

{ #category : #'tests - parent selector' }
ToStyleSelectorInterpreterTest >> testparentSelectorWithDepth [

	| engine parent directParentSelector1 directParentSelector2 parentParentSelector sub subsub |
	directParentSelector1 := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement).
	directParentSelector2 := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement) depth: 1.
	parentParentSelector := ToUniversalSelector new parent: (ToTypeSelector new type: ToElement) depth: 2.
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
