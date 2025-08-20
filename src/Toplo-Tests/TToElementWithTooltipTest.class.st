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
	space root addChild: e.
	self assert: e currentTooltipWindow isNil.
	e tooltipContent: (ToElement new
			 extent: 20 @ 20;
			 yourself).
	BlSpace simulateMouseMoveInside: e.
	BlSpace pulseUntilEmptyTaskQueue: space timeout: 11 milliSeconds.
	self assert: e currentTooltipWindow notNil.
	BlSpace simulateMouseMoveOutside: e.
	self assert: e currentTooltipWindow isNil.

	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testCloseTooltipOnMouseLeave2 [

	| e |
	e := ToElement new.
	e extent: 50 @ 50.
	e tooltipManagerDo: [:m | m closeOnMouseLeave: false ].
	e tooltipManagerDo: [ :m | m popupDelay: 10 milliSeconds ].
	space root addChild: e.
	self assert: e currentTooltipWindow isNil.
	e tooltipContent: (ToElement new
			 extent: 20 @ 20;
			 yourself).
	BlSpace simulateMouseMoveInside: e.
	BlSpace pulseUntilEmptyTaskQueue: space timeout: 11 milliSeconds.
	self assert: e currentTooltipWindow notNil.
	BlSpace simulateMouseMoveOutside: e.
	self assert: e currentTooltipWindow notNil.

	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testCurrentTooltipWindow [

	| e |
	e := ToElement new.
	e tooltipContent: ToElement new.
	self assert: e hasTooltip.
	self assert: e currentTooltipWindow isNil.
	e rawTooltipWindowManager newWindowEvent: nil.
	self assert: e currentTooltipWindow notNil.
	self
		assert: e currentTooltipWindow class
		equals: e tooltipWindowManager popupWindowClass.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testHasOpenedTooltip [

	| e |
	e := ToElement new.
	e tooltipContent: ToElement new.
	self assert: e currentTooltipWindow isNil.
	e rawTooltipWindowManager newWindowEvent: nil.
	self assert: e currentTooltipWindow notNil.
	self
		assert: e currentTooltipWindow class
		equals: e tooltipWindowManager popupWindowClass.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testHasTooltip [

	|  e  |
	e := ToElement new.
	self assert: e hasTooltip not.
	self should: [	e rawTooltipWindowManager newWindowEvent: nil ] raise: Error.
	e tooltipContent: ToElement new.
	self assert: e hasTooltip.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testNewTooltipWindowEvent [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e rawTooltipWindowManager isNil.
	self should: [	e rawTooltipWindowManager newWindowEvent: nil ] raise: Error.
	e tooltipContent: ToElement new.
	self assert: e hasTooltip.
	self assert: e rawTooltipWindowManager notNil.
	e rawTooltipWindowManager newWindowEvent: nil.
	self assert: e tooltipWindowManager currentWindow notNil.
	self assert: e currentTooltipWindow identicalTo: e tooltipWindowManager currentWindow.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testRawTooltipWindowManager [

	| e |
	e := ToElement new.
	self assert: e rawTooltipWindowManager isNil.
	e tooltipContent: ToElement new.
	self assert: e rawTooltipWindowManager notNil.
	e removeTooltipWindowManager.
	self assert: e rawTooltipWindowManager isNil.

]

{ #category : #tests }
TToElementWithTooltipTest >> testRemoveTooltip [

	|  e  |
	e := self testTooltip.
	self assert: e hasTooltip.
	e removeTooltip.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testRemoveTooltipWindowManager [

	| e |
	e := self testTooltip.
	self assert: e hasTooltip.
	self assert: (e userData includesKey: #tooltipWindowManager).
	e removeTooltipWindowManager.
	self deny: (e userData includesKey: #tooltipWindowManager).
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltip [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltip: [ :win :theRequest | win root addChild: tt ].
	self assert: e hasTooltip.
	ttwin := e rawTooltipWindowManager newWindowEvent: nil.
	self assert: e currentTooltipWindow identicalTo: ttwin.
	self assert: ttwin root firstChild identicalTo: tt.
	self assert: ttwin anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipBuilder [

	| e b |
	e := ToElement new.
	b := [ :win :theRequest | win root addChild: ToElement new ].
	e tooltipBuilder: b.
	self assert: e rawTooltipWindowManager notNil.
	self assert: e rawTooltipWindowManager windowBuilder identicalTo: b.
	e removeTooltipWindowManager.
	self assert: e rawTooltipWindowManager isNil
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipContent [

	|  e ttwin |
	e := self testTooltip.
	self assert: e hasTooltip.
	self assert: e tooltipWindowManager currentWindow notNil.
	ttwin := e tooltipWindowManager currentWindow.
	self assert: ttwin root firstChild notNil.
	e tooltipContent: nil.
	self assert: e currentTooltipWindow isNil.
	self assert: e hasTooltip not.

	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipPopupDelay [

	| e |
	e := ToElement new.
	e extent: 50 @ 50.
	e tooltipManagerDo: [ :m | 
		m popupDelay: 100 milliSeconds.
		self assert: m popupDelay equals: 100 milliSeconds].
	space root addChild: e.
	e tooltipContent: (ToElement new
			 extent: 20 @ 20;
			 yourself).
	BlSpace simulateMouseMoveInside: e.
	BlSpace pulseUntilEmptyTaskQueue: space timeout: 50 milliSeconds.
	BlSpace simulateMouseMoveOutside: e.
	self assert: e currentTooltipWindow isNil.
	BlSpace simulateMouseMoveInside: e.
	BlSpace pulseUntilEmptyTaskQueue: space timeout: 101 milliSeconds.
	self assert: e currentTooltipWindow notNil.

	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipRequestEvent [

	"test that context menu item are added on popup (an not on window instanciation)"
	| tt e ttwin request |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltip: [:win :theRequest | win root addChild: tt. request := theRequest].
	self assert: e hasTooltip.
	ttwin := e rawTooltipWindowManager newWindowEvent: nil.
	self assert: request class identicalTo: ttwin manager windowRequestClass.
	self assert: request target identicalTo: e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipString [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipString: 'X'.
	self assert: e hasTooltip.
	ttwin := e rawTooltipWindowManager newWindowEvent: nil.
	self assert: ttwin root firstChild notNil.
	self assert: ttwin root firstChild text asString equals: 'X'.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipText [

	| tt e ttwin |
	tt := BlElement new.
	e := ToElement new.
	self assert: e hasTooltip not.
	e tooltipText: ('X' asRopedText).
	self assert: e hasTooltip.
	ttwin := e rawTooltipWindowManager newWindowEvent: nil.
	self assert: ttwin root firstChild notNil.
	self assert: (ttwin root firstChild isKindOf: ToLabel).
	self assert: ttwin root firstChild text asString equals: 'X' asRopedText asString.
	^ e
]

{ #category : #tests }
TToElementWithTooltipTest >> testTooltipWindowManager [

	| e |
	e := ToElement new.
	self assert: e currentTooltipWindow isNil.
	self assert: e rawTooltipWindowManager isNil.
	e tooltip: [ :win :theRequest | win root addChild: ToElement new ].
	self assert: e hasTooltip.
	self assert: e rawTooltipWindowManager notNil.
	e rawTooltipWindowManager newWindowEvent: nil.
	self assert: e tooltipWindowManager currentWindow notNil.
	self assert: e tooltipWindowManager anchorElement identicalTo: e.
	^ e
]
