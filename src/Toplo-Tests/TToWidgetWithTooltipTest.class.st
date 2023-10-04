"
A TToWidgetWithTooltipTest is a test class for testing the behavior of TToWidgetWithTooltip
"
Class {
	#name : #TToWidgetWithTooltipTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Tooltip'
}

{ #category : #tests }
TToWidgetWithTooltipTest >> testRemoveTooltip [

	| tt e ttw |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltipContent.
	ttw := e privateTooltipWindow.
	self assert: ttw notNil.
	e removeTooltip.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: e privateTooltipWindow defaultAssociateElementEventHandlerClass ]) not.
	self assert: ttw associateElement isNil.
	self assert: ttw content isNil.
	self assert: e privateTooltipWindow isNil.
	self assert: e tooltipContent isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : #tests }
TToWidgetWithTooltipTest >> testTooltip [

	| tt e |
	tt := BlElement new.
	e := ToElementForWidgetWithTooltipTest new.
	self assert: e hasTooltip not.
	e tooltipContent: tt.
	self assert: e hasTooltip.
	self assert: e tooltipContent identicalTo: tt.
	self assert: e privateTooltipWindow associateElement identicalTo: e.
	self assert:
		(e privateTooltipWindow eventDispatcher hasEventHandlerSuchThat: [
			 :eh |
			 eh isKindOf: e privateTooltipWindow defaultEventHandlerClass ]).
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: e privateTooltipWindow defaultAssociateElementEventHandlerClass ]).
	^ e
]

{ #category : #tests }
TToWidgetWithTooltipTest >> testTooltipContent [

	| tt e |
	e := self testTooltip.
	self assert: e hasTooltip.
	tt := e tooltipContent.
	e tooltipContent: nil.
	self assert: tt hasParent not.
	self assert: e tooltipContent isNil.
	self assert: e privateTooltipWindow isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : #tests }
TToWidgetWithTooltipTest >> testWithoutTooltip [

	| ttc e ttw |
	e := ToElementForWidgetWithTooltipTest new.
	self assert: e hasTooltip not.
	ttc := e tooltipContent.
	self assert: ttc isNil.
	ttw := e privateTooltipWindow.
	self assert: ttw isNil.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: e privateTooltipWindow defaultAssociateElementEventHandlerClass ]) not.
	^ e
]
