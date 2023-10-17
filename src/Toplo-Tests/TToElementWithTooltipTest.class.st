"
A TToWidgetWithTooltipTest is a test class for testing the behavior of TToWidgetWithTooltip
"
Class {
	#name : 'TToElementWithTooltipTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
TToElementWithTooltipTest >> testCurrentTooltipWindow [

	| e |
	e := ToElement new.
	e tooltipContent: ToElement new.
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
TToElementWithTooltipTest >> testHasOpenedTooltip [

	| e |
	e := ToElement new.
	e tooltipContent: ToElement new.
	self assert: e hasOpenedTooltip not.
	self assert: e currentTooltipWindow isNil.
	e newTooltipWindowEvent: nil.
	self assert: e hasOpenedTooltip.
	self assert: e currentTooltipWindow notNil.
	self
		assert: e currentTooltipWindow class
		equals: e tooltipWindowHandler windowClass.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testHasTooltip [

	|  e  |
	e := ToElement new.
	self assert: e hasTooltip not.
	self should: [e newTooltipWindowEvent: nil] raise: Error.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	e tooltipContent: ToElement new.
	self assert: e hasTooltip.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testNewTooltipWindowEvent [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e rawTooltipWindowHandler isNil.
	self should: [ e newTooltipWindowEvent: nil ] raise: Error.
	e tooltipContent: ToElement new.
	self assert: e hasTooltip.
	self assert: e rawTooltipWindowHandler notNil.
	e newTooltipWindowEvent: nil.
	self assert: e tooltipWindowHandler currentWindow notNil.
	self assert: e currentTooltipWindow identicalTo: e tooltipWindowHandler currentWindow.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testRawTooltipWindowHandler [

	| e |
	e := ToElement new.
	self assert: e rawTooltipWindowHandler isNil.
	e tooltipContent: ToElement new.
	self assert: e rawTooltipWindowHandler notNil.
	e removeTooltipWindowHandler.
	self assert: e rawTooltipWindowHandler isNil.

]

{ #category : 'tests' }
TToElementWithTooltipTest >> testRemoveTooltip [

	|  e  |
	e := self testTooltip.
	self assert: e hasTooltip.
	e removeTooltip.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]) not.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testRemoveTooltipWindowHandler [

	| e |
	e := self testTooltip.
	self assert: e hasTooltip.
	self assert: (e userData includesKey: #tooltipWindowHandler).
	e removeTooltipWindowHandler.
	self deny: (e userData includesKey: #tooltipWindowHandler).
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltip [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltip: [:win :theElement | win root addChild: tt].
	self assert: e hasTooltip.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: e currentTooltipWindow identicalTo: ttwin.
	self assert: ttwin root firstChild identicalTo: tt.
	self assert: ttwin element identicalTo: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithTooltipEventHandler ]).
	ttwin close.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipBuilder [

	| e b |
	e := ToElement new.
	b := [ :win :theElement | win root addChild: ToElement new ].
	e tooltipBuilder: b.
	self assert: e rawTooltipWindowHandler notNil.
	self assert: e rawTooltipWindowHandler builder identicalTo: b.
	e removeTooltipWindowHandler.
	self assert: e rawTooltipWindowHandler isNil
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipContent [

	|  e ttwin |
	e := self testTooltip.
	self assert: e hasTooltip.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: ttwin root firstChild notNil.
	e tooltipContent: nil.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.

	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipString [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipString: 'X'.
	self assert: e hasTooltip.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: ttwin root firstChild notNil.
	self assert: ttwin root firstChild text asString equals: 'X'.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipText [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipText: ('X' asRopedText).
	self assert: e hasTooltip.
	ttwin := e newTooltipWindowEvent: nil.
	self assert: ttwin root firstChild notNil.
	self assert: (ttwin root firstChild isKindOf: ToLabel).
	self assert: ttwin root firstChild text asString equals: 'X' asRopedText asString.
	^ e
]

{ #category : 'tests' }
TToElementWithTooltipTest >> testTooltipWindowHandler [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e rawTooltipWindowHandler isNil.
	e tooltip: [:win :theElement | win root addChild: ToElement new].
	self assert: e hasTooltip.
	self assert: e rawTooltipWindowHandler notNil.
	e newTooltipWindowEvent: nil.
	self assert: e tooltipWindowHandler currentWindow notNil.
	self assert: e tooltipWindowHandler element identicalTo: e.
	^ e
]
