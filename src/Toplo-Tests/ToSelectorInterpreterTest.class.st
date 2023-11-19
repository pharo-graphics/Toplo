"
A ToStyleSelectorInterpreterTest is a test class for testing the behavior of ToStyleSelectorInterpreter
"
Class {
	#name : #ToSelectorInterpreterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Selector'
}

{ #category : #'tests - action selector' }
ToSelectorInterpreterTest >> testActionSelector [

	| selector e engine  |
	e := ToElement new.
	selector := ToActionSelector new action: [:target | target == e].
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result.

]

{ #category : #'tests - child selector' }
ToSelectorInterpreterTest >> testChildMixedWithParentSelector [

	| button innerElement icon label engine innerElementSelector buttonSelector |
	buttonSelector := (#button  asElementSelector
		                   child: #'button-label'
		                   depth: 2) "child: #'button-icon' depth: 2".
	innerElementSelector := #'inner-element' asElementSelector parent:
		                        buttonSelector.

	button := ToElement new.
	button withAllStamps: #( #button ).
	innerElement := ToElement new.
	innerElement withStamp: #'inner-element'.
	icon := ToElement new.
	icon withStamp: #'button-icon'.
	label := ToElement new.
	label withStamp: #'button-label'.

	button addChild: innerElement.
	innerElement addChild: icon.
	innerElement addChild: label.

	engine := ToSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.

	engine check: innerElementSelector on: innerElement.
	self assert: engine result
]

{ #category : #'tests - child selector' }
ToSelectorInterpreterTest >> testChildSelector [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToUniversalSelector new child: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: parent.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: parent.
	self assert: engine result.
	
]

{ #category : #'tests - child selector' }
ToSelectorInterpreterTest >> testChildSelectorWithDepth [

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

	engine := ToSelectorInterpreter new.

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
ToSelectorInterpreterTest >> testChildSelectorWithTwoChildrenDepth1 [

	| button icon label engine buttonSelector |
	buttonSelector := ((ToStampSelector new addStampName: #button) child: #'button-label' ).

	button := ToElement new.
	button withAllStamps: #( #button ).
	icon := ToElement new.
	icon withStamp: #'button-icon'.
	label := ToElement new.
	label withStamp: #'button-label'.

	button addChild: icon.
	button addChild: label.

	engine := ToSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.

]

{ #category : #'tests - child selector' }
ToSelectorInterpreterTest >> testChildSelectorWithTwoChildrenWithTwoChildSelectorsDepth2 [

	| button innerElement icon label engine buttonSelector |
	buttonSelector := ((ToStampSelector new addStampName: #button) child: #'button-label' depth: 2) child: #'button-icon' depth: 2.

	button := ToElement new id: #button.
	button withAllStamps: #( #button ).
	innerElement := ToElement new id: #innerElement.
	innerElement withStamp: #'inner-element'.
	icon := ToElement new id: #icon.
	icon withStamp: #'button-icon'.
	label := ToElement new id: #label.
	label withStamp: #'button-label'.

	button addChild: innerElement.
	innerElement addChild: icon.
	innerElement addChild: label.

	engine := ToSelectorInterpreter new.

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
ToSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass0 [

	" element with no class, selector without class "

	| selector e engine |
	selector := ToStampSelector new.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass1 [

	" element with a class, selector without class "

	| selector e engine |
	selector := ToStampSelector new.
	e := ToElement new withStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass2 [

	" element with a class, selector with the same class "

	| selector e engine |
	selector := ToStampSelector new addStampName: #a.
	e := ToElement new withStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass3 [

	" element with a class, selector with the a different class "

	| selector e engine |
	selector := ToStampSelector new addStampName: #b.
	e := ToElement new withStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	selector := ToStampSelector new addStampName: #b.
	e := ToElement new withStamp: #a.
	self assert: engine result not.


]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testClassSelectorWithElementWithoutClass4 [
	" element with multiple classes "

	| selector e engine |
	selector := ToStampSelector new addStampName: #a.
	e := ToElement new withStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e withStamp: #c.
	self assert: engine result.
	engine check: selector on: e.
	self assert: engine result.
	e withStamp: #b.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testNotSelector [

	| selector e engine |
	engine := ToSelectorInterpreter new.
	selector := ToTypeSelector new type: ToElement.
	e := ToElement new.
	engine check: selector on: e.
	self assert: engine result.
	
	selector := (ToTypeSelector new type: ToElement) not.
	engine check: selector on: e.
	self assert: engine result not.


]

{ #category : #'tests - parent selector' }
ToSelectorInterpreterTest >> testParentSelector [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToUniversalSelector new parent: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: e.
	self assert: engine result.
	
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testParentSelectorWithElementWithNoParent [

	| selector e engine |
	selector := ToParentSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - parent selector' }
ToSelectorInterpreterTest >> testParentSelectorWithoutLeft [

	" selector: an element with a parent of type Object "
	| selector e engine parent |
	selector := ToParentSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent == parent.
	engine := ToSelectorInterpreter new.
	selector right exact: false.
	engine check: selector on: e.
	" ok, the element e has a parent which is a kind of Object "
	self assert: engine result
	


	
]

{ #category : #'tests - and selector' }
ToSelectorInterpreterTest >> testRuleWithAndSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStampSelector new addAllStampNames: #( #button ))
	            + (ToStampSelector new addAllStampNames: #( #danger )).

	e := ToElement new withStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e withStamp: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result.

	selector := selector not.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndSiblingSelector [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := (ToStampSelector new addStampName: #child ) sibling: #sibling.

	parent := ToElement new.
	child := ToElement new withStamp: #child.
	sibling := ToElement new withStamp: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndSiblingSelector2 [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := ((ToStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #sibling.

	parent := ToElement new .
	child := ToElement new withStamp: #child.
	sibling := ToElement new withStamp: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent withStamp: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndSiblingSelector3 [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := ((ToStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #sibling.

	parent := ToElement new .
	child := ToElement new withStamp: #child.
	sibling := ToElement new withAllStamps: #(#image #sibling).
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent withStamp: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector [
	" a rule with an And operator  "

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStampSelector new addStampName: #child ) parent: #( #parent )) sibling: #'image-sibling') sibling: #'label-sibling'.

	parent := ToElement new .
	child := ToElement new withStamp: #child.
	sibling1 := ToElement new withAllStamps: #(#image #'image-sibling').
	sibling2 := ToElement new withAllStamps: #(#label #'label-sibling').
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.
	
	parent withStamp: #parent.
	
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result.
	
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector2 [
	" a rule with an And operator  "

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStampSelector new addStampName: #child) parent:
		              #( #parent )) sibling: #( #image #'image-sibling' ))
		            sibling: #( #label #'label-sibling' ).

	parent := ToElement new.
	child := ToElement new withStamp: #child.
	sibling1 := ToElement new withAllStamps: #( #image #'image-sibling' ).
	sibling2 := ToElement new withAllStamps: #( #label #'label-sibling' ).
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.

	parent withStamp: #parent.

	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - sibling selector' }
ToSelectorInterpreterTest >> testRuleWithAndTwoSiblingSelector3 [
	" a rule with an And operator  "

	| selector engine parent inner child sibling1 sibling2 |
	selector := (((ToStampSelector new addStampName: #child) 
						parent: #( #parent ) depth: 2) 
							sibling: #( #image #'image-sibling' ))
		     			       sibling: #( #label #'label-sibling' ).

	parent := ToElement new.
	inner := ToElement new.
	child := ToElement new withStamp: #child.
	sibling1 := ToElement new withAllStamps: #( #image #'image-sibling' ).
	sibling2 := ToElement new withAllStamps: #( #label #'label-sibling' ).
	parent addChild: inner.
	inner addChild: sibling1.
	inner addChild: child.
	inner addChild: sibling2.

	parent withStamp: #parent.

	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - and selector' }
ToSelectorInterpreterTest >> testRuleWithAndWithParentSelector [
	" a rule with an And operator  "

	| selector e engine child |
	selector := (ToStampSelector new addStampName: #'button-label')
		            parent:
			            (ToStampSelector new addStampName: #button)
			            + (ToStampSelector new addStampName: #danger )
		            depth: 1.

	e := ToElement new withStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e withStamp: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.
	e addChild: (child := ToElement new withStamp: #'button-label').
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.

	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - or selector' }
ToSelectorInterpreterTest >> testRuleWithOrSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStampSelector new addStampName: #button)
		            or: (ToStampSelector new addAllStampNames: #( #button #horizontal )).

	e := ToElement new withStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e withStamp: #horizontal.
	engine check: selector on: e.
	self assert: engine result.
	e withoutAllStamps.
	e withAllStamps: { #blob }.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #'tests - or selector' }
ToSelectorInterpreterTest >> testRuleWithOrWithParentSelector [
	" a rule with an Or operator with a child selector  "

	| selector e engine child |
	selector := (ToStampSelector new addStampName: #'inner-element')
		            parent: ((ToStampSelector new addAllStampNames:
				              #( #button #horizontal #justified )) or:
				             (ToStampSelector new addAllStampNames:
					              #( #button #justified )))
		            depth: 1.

	e := ToElement new withStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.

	e addChild: (child := ToElement new withStamp: #'inner-element').
	engine check: selector on: child.
	self assert: engine result not.

	e withStamp: #justified.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #'tests - type selector' }
ToSelectorInterpreterTest >> testTypeSelector [ 

	| selector e engine |
	selector := ToTypeSelector new type: ToElement.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
]

{ #category : #'tests - type selector' }
ToSelectorInterpreterTest >> testTypeSelectorAndChildSelector [

	| selector e engine |
	selector := (ToTypeSelector new type: ToLabeledIcon ) child: (ToTypeSelector new type: ToLabel).
	e := ToLabeledIcon new.
	e label: (ToLabel text: 'A').
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.

]

{ #category : #'tests - type selector' }
ToSelectorInterpreterTest >> testTypeSelectorAndParentSelector [

	| selector e engine |
	e := ToLabeledIcon new.
	e label: (ToLabel text: 'A').
	selector := (ToTypeSelector new type: ToLabel ) parent: (ToTypeSelector new type: ToLabeledIcon ) depth: 2.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	engine check: selector on: e label.
	self assert: engine result.
	selector := (ToUniversalSelector new ) parent: (ToTypeSelector new type: ToLabeledIcon ) depth: 2.
	engine check: selector on: e.
	self assert: engine result not.
	engine check: selector on: e label.
	self assert: engine result.


]

{ #category : #'tests - type selector' }
ToSelectorInterpreterTest >> testTypeSelectorExact [

	| selector engine |
	selector := ToTypeSelector new type: ToElement.
	engine := ToSelectorInterpreter new.
	self assert: selector exact.
	
	"Test if the selector trigger only the specicied class"
	engine check: selector on: (ToElement new).
	self assert: engine result.
	engine check: selector on: (ToButton new).
	self deny: engine result.
	
	selector exact: false.
	self deny: selector exact.
	
	"Test if the selector trigger the specicied class and all subclasses"
	engine check: selector on: (ToElement new).
	self assert: engine result.
	engine check: selector on: (ToButton new).
	self assert: engine result.
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testUniversalSelector [

	| selector e engine |
	selector := ToUniversalSelector new.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #'tests - with single selector' }
ToSelectorInterpreterTest >> testUniversalSelectorWithParent [

	| selector button engine chilLevel3 |	
	selector := ToUniversalSelector new parent: (ToStampSelector new addAllStampNames: #( #button #circle ) ) depth: 2.	
	button := ToElement new id: #button.
	button withAllStamps: #(#button #circle).
	button addChild: (ToElement new  id: #inner).
	button firstChild addChild: (chilLevel3 := ToElement new).
	chilLevel3 id: #childLevel3.
	engine := ToSelectorInterpreter new.
	engine check: selector on: chilLevel3.
	self assert: engine result 
]

{ #category : #'tests - parent selector' }
ToSelectorInterpreterTest >> testparentSelectorWithDepth [

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
	engine := ToSelectorInterpreter new.
	engine check: directParentSelector1 on: subsub.
	self assert: engine result.
	engine check: directParentSelector2 on: subsub.
	self assert: engine result.
	engine check: parentParentSelector on: subsub
]
