"
A TToWidgetWithTooltipTest is a test class for testing the behavior of TToWidgetWithTooltip
"
Class {
	#name : 'TToElementWithTooltipTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Tooltip',
	#package : 'Toplo-Tests',
	#tag : 'Core-Tooltip'
}

{ #category : 'tests' }
TToElementWithTooltipTest >> testCurrentTooltipWindow [

	| e |
	e := ToElement new.
	e tooltip: ToElement new.
	self assert: e hasTooltip.
	self assert: e currentTooltipWindow isNil.
	e newTooltipWindowEvent: nil.
	self assert: e currentTooltipWindow notNil.
	self
		assert: e currentTooltipWindow class
		equals: e tooltipWindowHandler windowClass.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testHasTooltip [

	| ttc e  |
	e := ToElement new.
	self assert: e hasTooltip not.
	ttc := e tooltip.
	self assert: ttc isNil.
	self should: [e newTooltipWindowEvent: nil] raise: Error.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	e tooltip: ToElement new.
	self assert: e hasTooltip.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testNewTooltipWindowEvent [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e tooltipWindowHandler isNil.
	self should: [ e newTooltipWindowEvent: nil ] raise: Error.
	e tooltip: ToElement new.
	self assert: e hasTooltip.
	self assert: e tooltipWindowHandler notNil.
	e newTooltipWindowEvent: nil.
	self assert: e tooltipWindowHandler currentWindow notNil.
	self assert: e currentTooltipWindow identicalTo: e tooltipWindowHandler currentWindow.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testPrivateRemoveTooltipWindowHandler [

	| e |
	e := self testTooltip.
	self assert: e hasTooltip.
	self assert: (e userData includesKey: #tooltip).
	e privateRemoveTooltipWindowHandler.
	self assert: (e userData includesKey: #tooltip).
	self assert: e tooltip notNil.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testRemoveTooltip [

	| tt e ttw |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltip.
	ttw := e newTooltipWindowEvent: nil.
	self assert: ttw notNil.
	e removeTooltip.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	self assert: ttw element isNil.
	self assert: e currentTooltipWindow isNil.
	self assert: e tooltip isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltip [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltip: tt.
	self assert: e hasTooltip.
	self assert: e tooltip identicalTo: tt.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: e currentTooltipWindow identicalTo: ttwin.
	self assert: ttwin element identicalTo: e.

	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]).
	ttwin close.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipContent [

	| tt e |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltip.
	e tooltipContent: nil.
	self assert: e tooltip isNil.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipString [

	| tt e |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipString: 'X'.
	self assert: e hasTooltip.
	self assert: (e tooltipContent isKindOf: ToLabel).
	self assert: e tooltipContent text asString equals: 'X'.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipText [

	| tt e |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipText: ('X' asRopedText).
	self assert: e hasTooltip.
	self assert: (e tooltipContent isKindOf: ToLabel).
	self assert: e tooltipContent text asString equals: 'X' asRopedText asString.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipWindowHandler [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e tooltipWindowHandler isNil.
	e tooltip: ToElement new.
	self assert: e hasTooltip.
	self assert: e tooltipWindowHandler notNil.
	e newTooltipWindowEvent: nil.
	self assert: e tooltipWindowHandler currentWindow notNil.
	self assert: e tooltipWindowHandler element identicalTo: e.
	^ e
]
