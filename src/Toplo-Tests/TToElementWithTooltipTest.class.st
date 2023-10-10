"
A TToWidgetWithTooltipTest is a test class for testing the behavior of TToWidgetWithTooltip
"
Class {
	#name : #TToElementWithTooltipTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Tooltip'
}

{ #category : #tests }
TToElementWithTooltipTest >> testRemoveTooltip [

	| tt e ttw |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltipContent.
	ttw := e newTooltipWindowEvent: nil.
	self assert: ttw notNil.
	e removeTooltip.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	self assert: ttw associateElement isNil.
	self assert: e currentTooltipWindow isNil.
	self assert: e tooltipContent isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltip [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipContent: tt.
	self assert: e hasTooltip.
	self assert: e tooltipContent identicalTo: tt.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: e currentTooltipWindow identicalTo: ttwin.
	self assert: ttwin associateElement identicalTo: e.
	self assert:
		(ttwin eventDispatcher hasEventHandlerSuchThat: [
			 :eh |
			 eh isKindOf: e currentTooltipWindow defaultEventHandlerClass ]).
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]).
	ttwin close.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipContent [

	| tt e |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltipContent.
	e tooltipContent: nil.
	self assert: e tooltipContent isNil.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testWithoutTooltip [

	| ttc e  |
	e := ToElement new.
	self assert: e hasTooltip not.
	ttc := e tooltipContent.
	self assert: ttc isNil.
	self should: [e newTooltipWindowEvent: nil] raise: Error.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	^ e
]
