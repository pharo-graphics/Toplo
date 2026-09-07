"
A TToWidgetWithTooltipTest is a test class for testing the behavior of TToWidgetWithTooltip
"
Class {
	#name : #TToElementWithTooltipTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToElementWithTooltipTest >> testCloseTooltipOnMouseLeave [

	| e |
	e := ToElement new.
	e extent: 50 @ 50.
	e tooltipManagerDo: [ :m | m popupDelay: 10 milliSeconds ].
	space deferAndSettle: [ space root addChild: e ].
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip window must be nil before opening'.

	e tooltipBuilder: [ :win :request |
			win root addChild: (ToElement new
					 extent: 20 @ 20;
					 yourself) ].
	e eventSimulator mouseMoveInside.
	space waitUntilTrue: [ e currentTooltipWindow notNil ].
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip window must open on mouse move inside'.

	e eventSimulator mouseMoveOutside.
	space waitUntilTrue: [ e currentTooltipWindow isNil ].
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip window must close on mouse move outside'
]

{ #category : #tests }
TToElementWithTooltipTest >> testCloseTooltipOnMouseLeave2 [

	| e |
	e := ToElement new.
	e extent: 50 @ 50.
	e tooltipManagerDo: [ :m | m closeOnLeaved: false ].
	e tooltipManagerDo: [ :m | m popupDelay: 10 milliSeconds ].
	space deferAndSettle: [ space root addChild: e ].
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip window must be nil before opening'.

	e tooltipBuilder: [ :win :request |
			win root addChild: (ToElement new
					 extent: 20 @ 20;
					 yourself) ].
	e eventSimulator mouseMoveInside.
	space waitUntilTrue: [ e currentTooltipWindow notNil ].
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip window must open on mouse move inside'.

	e eventSimulator mouseMoveOutside.
	space waitForDuration: 50 milliSeconds.
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip window must remain open when closeOnLeaved is false'
]

{ #category : #tests }
TToElementWithTooltipTest >> testCurrentTooltipWindow [

	| e |
	e := ToElement new.
	e tooltipBuilder: [ :win :request | win root addChild: ToElement new ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after installing builder'.
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip window must be nil before window creation'.

	e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip window must exist after creation'.
	self
		assert: e currentTooltipWindow class
		equals: e ensuredTooltipManager windowClass
]

{ #category : #tests }
TToElementWithTooltipTest >> testEnsuredTooltipManager [

	| e |
	e := ToElement new.
	self
		assert: e currentTooltipWindow isNil
		description: 'New element must have no current tooltip window'.
	self
		assert: e rawTooltipManager isNil
		description: 'New element must have no raw tooltip manager'.

	e tooltip: [ :win :theRequest | win root addChild: ToElement new ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after setting tooltip'.
	self
		assert: e rawTooltipManager notNil
		description: 'Raw tooltip manager must exist after setting tooltip'.

	e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: e ensuredTooltipManager currentWindow notNil
		description: 'Current window must exist after creation'.
	self
		assert: e ensuredTooltipManager anchorElement
		identicalTo: e
]

{ #category : #tests }
TToElementWithTooltipTest >> testHasOpenedTooltip [

	| e |
	e := ToElement new.
	e tooltipBuilder: [ :win :request | win root addChild: ToElement new ].
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip window must be nil before window creation'.

	e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip window must exist after window creation'.
	self
		assert: e currentTooltipWindow class
		equals: e ensuredTooltipManager windowClass
]

{ #category : #tests }
TToElementWithTooltipTest >> testHasTooltip [

	| e |
	e := ToElement new.
	self
		assert: e hasTooltip not
		description: 'New element must not have tooltip'.
	self
		should: [ e rawTooltipManager createNewWindowOnEvent: nil ]
		raise: Error.

	e tooltipBuilder: [ :win :request | win root addChild: ToElement new ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after installing builder'
]

{ #category : #tests }
TToElementWithTooltipTest >> testNewTooltipOnEvent [

	| e |
	e := ToElement new.
	self
		assert: e currentTooltipWindow isNil
		description: 'New element must have no current tooltip window'.
	self
		assert: e rawTooltipManager isNil
		description: 'New element must have no raw tooltip manager'.
	self
		should: [ e rawTooltipManager createNewWindowOnEvent: nil ]
		raise: Error.

	e tooltipBuilder: [ :win :request | win root addChild: ToElement new ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after installing builder'.
	self
		assert: e rawTooltipManager notNil
		description: 'Raw tooltip manager must exist after installing builder'.

	e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: e ensuredTooltipManager currentWindow notNil
		description: 'Current window must exist after creation'.
	self
		assert: e currentTooltipWindow
		identicalTo: e ensuredTooltipManager currentWindow
]

{ #category : #tests }
TToElementWithTooltipTest >> testRawTooltipManager [

	| e |
	e := ToElement new.
	self
		assert: e rawTooltipManager isNil
		description: 'New element must have no raw tooltip manager'.

	e tooltipBuilder: [ :win :request | win root addChild: ToElement new ].
	self
		assert: e rawTooltipManager notNil
		description: 'Raw tooltip manager must exist after installing builder'.

	e removeTooltipManager.
	self
		assert: e rawTooltipManager isNil
		description: 'Raw tooltip manager must be nil after removal'
]

{ #category : #tests }
TToElementWithTooltipTest >> testRemoveTooltip [

	| e |
	e := self testTooltip.
	self
		assert: e hasTooltip
		description: 'Element must have tooltip from testTooltip'.

	e removeTooltip.
	self
		assert: e currentTooltipWindow isNil
		description: 'Current tooltip window must be nil after removing tooltip'.
	self
		assert: e hasTooltip not
		description: 'Element must not have tooltip after removing tooltip'
]

{ #category : #tests }
TToElementWithTooltipTest >> testRemoveTooltipManager [

	| e |
	e := self testTooltip.
	self
		assert: e hasTooltip
		description: 'Element must have tooltip from testTooltip'.
	self
		assert: (e userData includesKey: #tooltipManager)
		description: 'User data must contain tooltipManager key'.

	e removeTooltipManager.
	self
		deny: (e userData includesKey: #tooltipManager)
		description: 'User data must not contain tooltipManager key after removal'
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltip [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self
		assert: e hasTooltip not
		description: 'New element must not have tooltip'.

	e tooltip: [ :win :theRequest | win root addChild: tt ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after configuration'.

	ttwin := e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: e currentTooltipWindow
		identicalTo: ttwin.
	self
		assert: ttwin root firstChild
		identicalTo: tt.
	self
		assert: ttwin anchorElement
		identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipBuilder [

	| e b |
	e := ToElement new.
	b := [ :win :theRequest | win root addChild: ToElement new ].
	e tooltipBuilder: b.
	self
		assert: e rawTooltipManager notNil
		description: 'Raw tooltip manager must exist after setting builder'.
	self
		assert: e rawTooltipManager windowBuilder
		identicalTo: b.

	e removeTooltipManager.
	self
		assert: e rawTooltipManager isNil
		description: 'Raw tooltip manager must be nil after removal'
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipPopupDelay [

	| e |
	e := ToElement new.
	e extent: 50 @ 50.

	"Set the delay threshold after which the tooltip opens"
	e tooltipManagerDo: [ :m |
		m popupDelay: 300 milliSeconds.
		self assert: m popupDelay equals: 300 milliSeconds ].

	space deferAndSettle: [
		space root addChild: e.
		e tooltipBuilder: [ :win :request |
			win root addChild: (ToElement new
					 extent: 20 @ 20;
					 yourself) ] ].

	"Hovering starts the delay countdown; the tooltip must not appear immediately"
	e eventSimulator mouseMoveInside.
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip must not open immediately upon mouse enter'.

	"After a little wait, the tooltip must still not be opened"
	space waitForDuration: 20 milliSeconds.
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip must remain closed before popupDelay elapses'.

	"Once the delay elapses, the tooltip window opens"
	space waitUntilTrue: [ e currentTooltipWindow notNil ].
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip must open after popupDelay elapses'.

	"Moving the mouse outside closes the tooltip"
	e eventSimulator mouseMoveOutside.
	space waitUntilTrue: [ e currentTooltipWindow isNil ].
	self
		assert: e currentTooltipWindow isNil
		description: 'Tooltip must close upon mouse move outside'.

	"Re-entering the element starts a new delay cycle and opens the tooltip again"
	e eventSimulator mouseMoveInside.
	space waitUntilTrue: [ e currentTooltipWindow notNil ].
	self
		assert: e currentTooltipWindow notNil
		description: 'Tooltip must open again on re-entering element'
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipRequestEvent [

	"test that context menu item are added on popup (an not on window instanciation)"
	| tt e ttwin request |
	tt := BlElement new.
	e := ToElement new.
	self
		deny: e hasTooltip
		description: 'New element must not have tooltip'.

	e tooltip: [ :win :theRequest | win root addChild: tt. request := theRequest ].
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after configuration'.

	ttwin := e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: request class
		identicalTo: ttwin manager windowRequestClass.
	self
		assert: request target
		identicalTo: e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipString [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self
		assert: e hasTooltip not
		description: 'New element must not have tooltip'.

	e tooltipString: 'X'.
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after setting tooltipString'.

	ttwin := e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: ttwin root firstChild notNil
		description: 'Tooltip window must contain a child'.
	self
		assert: ttwin root firstChild text asString
		equals: 'X'
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipText [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self
		assert: e hasTooltip not
		description: 'New element must not have tooltip'.

	e tooltipText: 'X' asRopedText.
	self
		assert: e hasTooltip
		description: 'Element must have tooltip after setting tooltipText'.

	ttwin := e rawTooltipManager createNewWindowOnEvent: nil.
	self
		assert: ttwin root firstChild notNil
		description: 'Tooltip window must contain a child'.
	self
		assert: (ttwin root firstChild isKindOf: ToLabel)
		description: 'Tooltip content child must be a ToLabel'.
	self
		assert: ttwin root firstChild text asString
		equals: 'X' asRopedText asString
]
