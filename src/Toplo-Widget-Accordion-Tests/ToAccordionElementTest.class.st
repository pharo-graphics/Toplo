"
I check the behavior of `ToAccordionElement` stated in its class comment: an accordion starts collapsed, builds its body lazily and keeps it unless told otherwise, toggles when its header is clicked, turns its arrow, and follows the rules of a `ToCheckableGroupPane`.

I count how many times a body builder runs in `bodyBuildCount`, so that lazy building and rebuilding can be asserted.
"
Class {
	#name : #ToAccordionElementTest,
	#superclass : #ToTestCaseWithSpace,
	#instVars : [
		'bodyBuildCount'
	],
	#category : #'Toplo-Widget-Accordion-Tests'
}

{ #category : #helpers }
ToAccordionElementTest >> newAccordion [
	"An accordion whose body builder counts its runs in bodyBuildCount."

	bodyBuildCount := 0.
	^ ToAccordionElement new
		  headerBuilder: [ :header | header addChild: (ToLabel text: 'Header') ];
		  bodyBuilder: [ :body |
			  bodyBuildCount := bodyBuildCount + 1.
			  body addChild: (ToLabel text: 'Body') ];
		  yourself
]

{ #category : #helpers }
ToAccordionElementTest >> newAccordionInSpace [
	"An accordion added to the test space, with its skin installed."

	| accordion |
	accordion := self newAccordion.
	space root addChild: accordion.
	space settle.
	^ accordion
]

{ #category : #helpers }
ToAccordionElementTest >> newGroupPaneWith: aCollection [

	| pane |
	pane := ToCheckableGroupPane vertical.
	aCollection do: [ :each | pane addChild: each ].
	^ pane
]

{ #category : #tests }
ToAccordionElementTest >> testArrowPointsDownWhenExpanded [

	| accordion |
	accordion := self newAccordionInSpace.
	accordion expand.
	space settle.
	self assert: accordion header icon isDown
]

{ #category : #tests }
ToAccordionElementTest >> testArrowPointsRightWhenCollapsed [

	self assert: self newAccordionInSpace header icon isRight
]

{ #category : #tests }
ToAccordionElementTest >> testBodyIsBuiltAtFirstExpansion [

	| accordion |
	accordion := self newAccordion.
	accordion expand.
	self assert: bodyBuildCount equals: 1.
	self assert: accordion body content childrenCount equals: 1
]

{ #category : #tests }
ToAccordionElementTest >> testBodyIsNotBuiltBeforeFirstExpansion [

	| accordion |
	accordion := self newAccordion.
	self assert: bodyBuildCount equals: 0.
	self assert: accordion body content childrenCount equals: 0
]

{ #category : #tests }
ToAccordionElementTest >> testClickOnHeaderExpands [

	| accordion |
	accordion := self newAccordionInSpace.
	accordion header eventSimulator click.
	space settle.
	self assert: accordion isExpanded
]

{ #category : #tests }
ToAccordionElementTest >> testClickOnHeaderOfExpandedAccordionCollapses [

	| accordion |
	accordion := self newAccordionInSpace.
	accordion expand.
	space settle.
	accordion header eventSimulator click.
	space settle.
	self assert: accordion isCollapsed
]

{ #category : #tests }
ToAccordionElementTest >> testCollapsedBodyHasNoHeight [

	| accordion |
	accordion := self newAccordionInSpace.
	accordion expand.
	space settle.
	self assert: accordion body height > 0.
	accordion collapse.
	space settle.
	self assert: accordion body height isZero
]

{ #category : #tests }
ToAccordionElementTest >> testDefaultCheckableGroupKeepsOneAccordionExpanded [

	| first second |
	first := self newAccordion.
	second := self newAccordion.
	self newGroupPaneWith: {
		first.
		second }.
	first expand.
	second expand.
	self deny: first isExpanded.
	self assert: second isExpanded.
	second collapse.
	self assert: second isExpanded
]

{ #category : #tests }
ToAccordionElementTest >> testExpandAndCollapse [

	| accordion |
	accordion := self newAccordion.
	accordion expand.
	self assert: accordion isExpanded.
	accordion collapse.
	self assert: accordion isCollapsed
]

{ #category : #tests }
ToAccordionElementTest >> testHeaderIsBuiltImmediately [

	self assert: self newAccordion header content childrenCount equals: 1
]

{ #category : #tests }
ToAccordionElementTest >> testNewAccordionIsCollapsed [

	| accordion |
	accordion := self newAccordion.
	self deny: accordion isExpanded.
	self assert: accordion isCollapsed
]

{ #category : #tests }
ToAccordionElementTest >> testNotPreservedBodyIsRebuiltAtEachExpansion [

	| accordion |
	accordion := self newAccordion.
	accordion preserveBody: false.
	accordion
		expand;
		collapse;
		expand.
	self assert: bodyBuildCount equals: 2.
	self assert: accordion body content childrenCount equals: 1
]

{ #category : #tests }
ToAccordionElementTest >> testPreservedBodyIsBuiltOnce [

	| accordion |
	accordion := self newAccordion.
	accordion
		expand;
		collapse;
		expand.
	self assert: bodyBuildCount equals: 1
]

{ #category : #tests }
ToAccordionElementTest >> testWeakCheckableGroupAllowsCollapsingAll [

	| first second pane |
	first := self newAccordion.
	second := self newAccordion.
	pane := self newGroupPaneWith: {
		        first.
		        second }.
	pane group withWeakCheckingStrategy.
	first expand.
	second expand.
	self deny: first isExpanded.
	second collapse.
	self deny: second isExpanded
]
