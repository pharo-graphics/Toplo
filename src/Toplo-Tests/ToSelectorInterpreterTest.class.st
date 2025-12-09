"
A ToStyleSelectorInterpreterTest is a test class for testing the behavior of ToStyleSelectorInterpreter
"
Class {
	#name : #ToSelectorInterpreterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Selectors'
}

{ #category : #tests }
ToSelectorInterpreterTest >> testPush [

	| selector e engine theme |
	selector := ToIdSelector new id: #'my-id'.
	e := ToElement new.
	e id: #'my-id'.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result.	
	theme := ToThemeForStyleRuleTest new.
	engine theme: theme.
	engine check: selector on: e.
	self assert: engine result

	
	
]

{ #category : #tests }
ToSelectorInterpreterTest >> testResult [

	| selector e engine  |
	e := ToElement new.
	selector := ToActionSelector new action: [:target | target == e].
	engine := ToSelectorInterpreter new.
	self deny: engine result.
	engine check: selector on: e.
	self assert: engine result.

]

{ #category : #tests }
ToSelectorInterpreterTest >> testTheme [

	| engine  th |
	engine := ToSelectorInterpreter new.
	self assert: engine theme isNil.
	engine theme: (th := Toplo newDefaultThemeInstance ).
	self assert: engine theme identicalTo: th

]

{ #category : #tests }
ToSelectorInterpreterTest >> testThemeDo [

	| engine wentHere|
	engine := ToSelectorInterpreter new.
	wentHere := false.
	self assert: engine theme isNil.
	engine themeDo: [ :th | wentHere := true ].
	self deny: wentHere.
	engine theme: Toplo newDefaultThemeInstance.
	engine themeDo: [ :th | wentHere := true ].
	self assert: wentHere.

]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitActionSelector [

	| selector e engine  |
	e := ToElement new.
	selector := ToActionSelector new action: [:target | target == e].
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result.

]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitAndSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStampSelector new addAllStamps: #( #button ))
	            && (ToStampSelector new addAllStamps: #( #danger )).

	e := ToElement new addStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e addStamp: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result.

	selector := selector not.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitAndSelectorWithParentSelector [
	" a rule with an And operator  "

	| selector e engine child |
	selector := (ToStampSelector new addStamp: #'button-label')
		            withParent: (ToStampSelector new addStamp: #button)
			            && (ToStampSelector new addStamp: #danger)
		            atDepth: 1.

	e := ToElement new addStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	e addStamp: #danger.
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.
	e addChild: (child := ToElement new addStamp: #'button-label').
	" ko since no child "
	engine check: selector on: e.
	self assert: engine result not.

	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitChildSelector [
	" selector: an element with a parent of type Object "

	| selector e engine parent |
	selector := ToUniversalSelector new withChild:
		            (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent identicalTo: parent.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: parent.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: parent.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitChildSelectorMixedWithParentSelector [

	| button innerElement icon label engine innerElementSelector buttonSelector |
	buttonSelector := #button asStampSelector
		                  withChild: #'button-label' asStampSelector 
		                  atDepth: 2. 
	innerElementSelector := #'inner-element' asStampSelector
		                        withParent: buttonSelector.

	button := ToElement new.
	button addAllStamps: #( #button ).
	innerElement := ToElement new.
	innerElement addStamp: #'inner-element'.
	icon := ToElement new.
	icon addStamp: #'button-icon'.
	label := ToElement new.
	label addStamp: #'button-label'.

	button addChild: innerElement.
	innerElement addChild: icon.
	innerElement addChild: label.

	engine := ToSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result.

	engine check: innerElementSelector on: innerElement.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitChildSelectorWithDepth [

	| childSelectorAnyDepth childSelectorDepth1 childSelectorDepth2 sub subsub parent engine |
	childSelectorAnyDepth := ToUniversalSelector new withChild:
		                         (ToTypeSelector new type: ToElement).
	childSelectorDepth1 := ToUniversalSelector new
		                       withChild:
		                       (ToTypeSelector new type: ToElement)
		                       atDepth: 1.
	childSelectorDepth2 := ToUniversalSelector new
		                       withChild:
		                       (ToTypeSelector new type: ToElement)
		                       atDepth: 2.

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

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitChildSelectorWithTwoChildrenDepth1 [

	| button icon label engine buttonSelector |
	buttonSelector := (ToStampSelector new addStamp: #button) withChild:
		                  #'button-label' asStampSelector.

	button := ToElement new.
	button addAllStamps: #( #button ).
	icon := ToElement new.
	icon addStamp: #'button-icon'.
	label := ToElement new.
	label addStamp: #'button-label'.

	button addChild: icon.
	button addChild: label.

	engine := ToSelectorInterpreter new.

	engine check: buttonSelector on: button.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitChildSelectorWithTwoChildrenWithTwoChildSelectorsDepth2 [

	| button innerElement icon label engine buttonSelector |
	buttonSelector := ((ToStampSelector new addStamp: #button)
		                   withChild: #'button-label' asStampSelector 
		                   atDepth: 2) withChild: #'button-icon' asStampSelector atDepth: 2.

	button := ToElement new id: #button.
	button addAllStamps: #( #button ).
	innerElement := ToElement new id: #innerElement.
	innerElement addStamp: #'inner-element'.
	icon := ToElement new id: #icon.
	icon addStamp: #'button-icon'.
	label := ToElement new id: #label.
	label addStamp: #'button-label'.

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
	self assert: engine result not
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitIdSelector [

	| selector e engine |
	selector := ToIdSelector new id: #'my-id'.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result not.
	e id: #'my-id'.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitNoneSelector [
	" the result is always false "

	| selector e engine |
	selector := ToIdSelector new id: #'my-id'.
	selector := ToNoneSelector new left: selector.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self deny: engine result.
	e id: #'my-id'.
	engine check: selector on: e.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitNoneSelector2 [
	" the result is alway false "

	| selector e engine |
	selector := ToUniversalSelector new .
	selector := ToNoneSelector new left: selector.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitNotSelector [

	| selector e engine |
	selector := ToIdSelector new id: #'my-id'.
	selector := ToNotSelector new left: selector.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result.
	e id: #'my-id'.
	engine check: selector on: e.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitNotSelector2 [

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

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitOrSelector [
	" a rule with an And operator  "

	| selector e engine |
	selector := (ToStampSelector new addStamp: #button)
	            ||
	            (ToStampSelector new addAllStamps:
		             #( #button #horizontal )).

	e := ToElement new addStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e addStamp: #horizontal.
	engine check: selector on: e.
	self assert: engine result.
	e removeAllStamps.
	e addAllStamps: { #blob }.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitOrSelectorWithParentSelector [
	" a rule with an Or operator with a child selector  "

	| selector e engine child |
	selector := (ToStampSelector new addStamp: #'inner-element')
		            withParent:
			            (ToStampSelector new addAllStamps:
				             #( #button #horizontal #justified ))
			            ||
			            (ToStampSelector new addAllStamps:
				             #( #button #justified ))
		            atDepth: 1.

	e := ToElement new addStamp: #button.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.

	e addChild: (child := ToElement new addStamp: #'inner-element').
	engine check: selector on: child.
	self assert: engine result not.

	e addStamp: #justified.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector [

	| engine selector button label |
	selector := ToUniversalSelector new
		            withParent: #'big-button' asStampSelector
		            satisfying: ToButton asTypeSelector.

	button := ToButton new.
	label := ToLabel new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: label.
	self deny: engine result.
	button label: label.
	button applyConfiguration.

	engine check: selector on: label.
	self deny: engine result.
	button addStamp: #'big-button'.
	engine check: selector on: label.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector0 [
	" fails if the element has no parent "

	| engine selector button |
	selector := ToUniversalSelector new
		            withParent: #'big-button' asStampSelector
		            satisfying: ToButton asTypeSelector.

	button := ToButton new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: button.
	self deny: engine result.
	button addStamp: #'big-button'.
	engine check: selector on: button.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector2 [

	| engine selector element label |
	selector := ToUniversalSelector new
		            withParent: #'big-button' asStampSelector
		            satisfying: ToButton asTypeSelector.

	element := ToLabeledIcon new.
	label := ToLabel new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: label.
	self deny: engine result.
	element label: label.
	engine check: selector on: label.
	self deny: engine result.
	element addStamp: #'big-button'.
	engine check: selector on: label.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector3 [

	| engine selector element label |
	selector := ToUniversalSelector new
		            withParent: #'big-button' asStampSelector
		            satisfying: ToLabeledIcon asTypeSelector.

	element := ToLabeledIcon new.
	label := ToLabel new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: label.
	self deny: engine result.
	element label: label.
	element applyConfiguration.

	engine check: selector on: label.
	self deny: engine result.
	element addStamp: #'big-button'.
	engine check: selector on: label.
	self assert: engine result.
	

]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector4 [

	| engine selector element label |
	selector := ToUniversalSelector new
		            withParent: ToLabeledIcon asTypeSelector
		            satisfying: #'big-button' asStampSelector .

	element := ToLabeledIcon new.
	label := ToLabel new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: label.
	self deny: engine result.
	element label: label.
	element applyConfiguration.

	engine check: selector on: label.
	self deny: engine result.
	element addStamp: #'big-button'.
	engine check: selector on: label.
	self assert: engine result.
	

]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSatisfyingSelector5 [

	| engine selector element label |
	selector := ToUniversalSelector new
		            withParent: ToLabeledIcon asTypeSelector
		            satisfying:
		            [ :p | p hasStamp: #'big-button' ] asActionSelector.

	element := ToLabeledIcon new.
	label := ToLabel new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: label.
	self deny: engine result.
	element label: label.
	element applyConfiguration.

	engine check: selector on: label.
	self deny: engine result.
	element addStamp: #'big-button'.
	engine check: selector on: label.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSelector [
	" selector: an element with a parent of type Object "

	| selector e engine parent |
	selector := ToUniversalSelector new withParent:
		            (ToTypeSelector new type: Object).
	e := ToElement new.
	parent := ToElement new.
	parent addChild: e.
	self assert: e parent identicalTo: parent.
	engine := ToSelectorInterpreter new.
	" the result is false since the selector is exact by default "
	engine check: selector on: e.
	self assert: engine result not.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSelector0 [
	" selector: an element with a parent of type ToElement fails 
	if runned on anElement without any parent event the selected type matches"

	| selector e engine |
	selector := ToUniversalSelector new withParent:
		            (ToTypeSelector new type: ToElement).
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self deny: engine result.
	" now allow isKindOf: "
	selector right exact: false.
	engine check: selector on: e.
	self deny: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSelectorWithDepth [

	| engine parent directParentSelector1 directParentSelector2 parentParentSelector sub subsub |
	directParentSelector1 := ToUniversalSelector new withParent:
		                         (ToTypeSelector new type: ToElement).
	directParentSelector2 := ToUniversalSelector new
		                         withParent:
		                         (ToTypeSelector new type: ToElement)
		                         atDepth: 1.
	parentParentSelector := ToUniversalSelector new
		                        withParent:
		                        (ToTypeSelector new type: ToElement)
		                        atDepth: 2.
	sub := ToElement new.
	subsub := ToElement new.
	parent := ToElement new.
	parent addChild: subsub.
	subsub addChild: sub.
	self assert: subsub parent identicalTo: parent.
	engine := ToSelectorInterpreter new.
	engine check: directParentSelector1 on: subsub.
	self assert: engine result.
	engine check: directParentSelector2 on: subsub.
	self assert: engine result.
	engine check: parentParentSelector on: subsub
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSelectorWithElementWithNoParent [

	| selector e engine |
	selector := ToParentSelector new right: (ToTypeSelector new type: Object).
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitParentSelectorWithoutLeft [

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

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelector [
	" a rule with an And operator  "

	| selector engine parent child sibling |
	selector := (ToStampSelector new addStamp: #child) withSibling:
		            #sibling asStampSelector.

	parent := ToElement new.
	child := ToElement new addStamp: #child.
	sibling := ToElement new addStamp: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelector2 [

	| selector engine parent child sibling |
	selector := ((ToStampSelector new addStamp: #child) withParent:
		             #( #parent ) asStampSelector) withSibling:
		            #sibling asStampSelector.

	parent := ToElement new.
	child := ToElement new addStamp: #child.
	sibling := ToElement new addStamp: #sibling.
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent addStamp: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelector3 [

	| selector engine parent child sibling |
	selector := ((ToStampSelector new addStamp: #child) withParent:
		             #( #parent ) asStampSelector) withSibling:
		            #sibling asStampSelector.

	parent := ToElement new.
	child := ToElement new addStamp: #child.
	sibling := ToElement new addAllStamps: #( #image #sibling ).
	parent addChild: child.
	parent addChild: sibling.
	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	" result false since parent do not have #parent tag "
	self assert: engine result not.
	parent addStamp: #parent.
	" should be ok now "
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelectorTwoSiblingSelectors [

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStampSelector new addStamp: #child) withParent:
		              #( #parent ) asStampSelector) withSibling:
		             #'image-sibling' asStampSelector) withSibling:
		            #'label-sibling' asStampSelector.

	parent := ToElement new.
	child := ToElement new addStamp: #child.
	sibling1 := ToElement new addAllStamps: #( #image #'image-sibling' ).
	sibling2 := ToElement new addAllStamps: #( #label #'label-sibling' ).
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.

	parent addStamp: #parent.

	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelectorTwoSiblingSelectors2 [
	" a rule with an And operator  "

	| selector engine parent child sibling1 sibling2 |
	selector := (((ToStampSelector new addStamp: #child) withParent:
		              #( #parent ) asStampSelector) withSibling:
		             #( #image #'image-sibling' ) asStampSelector)
		            withSibling:
		            #( #label #'label-sibling' ) asStampSelector.

	parent := ToElement new.
	child := ToElement new addStamp: #child.
	sibling1 := ToElement new addAllStamps: #( #image #'image-sibling' ).
	sibling2 := ToElement new addAllStamps: #( #label #'label-sibling' ).
	parent addChild: sibling1.
	parent addChild: child.
	parent addChild: sibling2.

	parent addStamp: #parent.

	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitSiblingSelectorTwoSiblingSelectors3 [
	" a rule with an And operator  "

	| selector engine parent inner child sibling1 sibling2 |
	selector := (((ToStampSelector new addStamp: #child)
		              withParent: #( #parent ) asStampSelector
		              atDepth: 2) withSibling:
		             #( #image #'image-sibling' ) asStampSelector)
		            withSibling:
		            #( #label #'label-sibling' ) asStampSelector.

	parent := ToElement new.
	inner := ToElement new.
	child := ToElement new addStamp: #child.
	sibling1 := ToElement new addAllStamps: #( #image #'image-sibling' ).
	sibling2 := ToElement new addAllStamps: #( #label #'label-sibling' ).
	parent addChild: inner.
	inner addChild: sibling1.
	inner addChild: child.
	inner addChild: sibling2.

	parent addStamp: #parent.

	engine := ToSelectorInterpreter new.
	engine check: selector on: child.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelector [

	" element with no class, selector without class "

	| selector e engine |
	selector := ToStampSelector new.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelectorWithElementWithoutClass0 [

	" element with no class, selector without class "

	| selector e engine |
	selector := ToStampSelector new.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelectorWithElementWithoutClass1 [

	" element with a class, selector without class "

	| selector e engine |
	selector := ToStampSelector new.
	e := ToElement new addStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelectorWithElementWithoutClass2 [

	" element with a class, selector with the same class "

	| selector e engine |
	selector := ToStampSelector new addStamp: #a.
	e := ToElement new addStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result 
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelectorWithElementWithoutClass3 [

	" element with a class, selector with the a different class "

	| selector e engine |
	selector := ToStampSelector new addStamp: #b.
	e := ToElement new addStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	selector := ToStampSelector new addStamp: #b.
	e := ToElement new addStamp: #a.
	self assert: engine result not.


]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitStyleStampSelectorWithElementWithoutClass4 [
	" element with multiple classes "

	| selector e engine |
	selector := ToStampSelector new addStamp: #a.
	e := ToElement new addStamp: #a.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
	e addStamp: #c.
	self assert: engine result.
	engine check: selector on: e.
	self assert: engine result.
	e addStamp: #b.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitTypeSelector [ 

	| selector e engine |
	selector := ToTypeSelector new type: ToElement.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result.
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitTypeSelectorAndChildSelector [

	| selector e engine |
	selector := (ToTypeSelector new type: ToLabeledIcon) withChild:
		            (ToTypeSelector new type: ToLabel).
	e := ToLabeledIcon new.
	e label: (ToLabel text: 'A').
	e applyConfiguration.

	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitTypeSelectorAndParentSelector [

	| selector e engine |
	e := ToLabeledIcon new.
	e label: (ToLabel text: 'A').
	e applyConfiguration.

	selector := (ToTypeSelector new type: ToLabel)
		            withParent: (ToTypeSelector new type: ToLabeledIcon)
		            atDepth: 2.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result not.
	engine check: selector on: e label.
	self assert: engine result.
	selector := ToUniversalSelector new
		            withParent: (ToTypeSelector new type: ToLabeledIcon)
		            atDepth: 2.
	engine check: selector on: e.
	self assert: engine result not.
	engine check: selector on: e label.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitTypeSelectorExact [

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

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitUniversalSelector [

	| selector e engine |
	selector := ToUniversalSelector new.
	e := ToElement new.
	engine := ToSelectorInterpreter new.
	engine check: selector on: e.
	self assert: engine result
]

{ #category : #tests }
ToSelectorInterpreterTest >> testVisitUniversalSelectorWithParent [

	| selector button engine chilLevel3 |
	selector := ToUniversalSelector new
		            withParent:
		            (ToStampSelector new addAllStamps: #( #button #circle ))
		            atDepth: 2.
	button := ToElement new id: #button.
	button addAllStamps: #( #button #circle ).
	button addChild: (ToElement new id: #inner).
	button firstChild addChild: (chilLevel3 := ToElement new).
	chilLevel3 id: #childLevel3.
	engine := ToSelectorInterpreter new.
	engine check: selector on: chilLevel3.
	self assert: engine result
]
