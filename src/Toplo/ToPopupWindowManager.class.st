Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'popupDelay',
		'autoCloseDelay',
		'delayedPopupHandler',
		'popupOnPressed',
		'closeOnLeaved',
		'closeOnReleased',
		'checkOutsideEvent',
		'outsideEventFilter',
		'popover'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay [
	" a minimal delay between the opening (on mouse down as an example) 
	and a close request of the window (on mouse up as an example).
	used to not close a window immediately after its opening (menu).
	nil means no autoclosing.
	"

	^ autoCloseDelay ifNil: [ autoCloseDelay:= self defaultAutoCloseDelay ]
]

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay: aDelay [
	" a minimal delay between the opening (on mouse down as an example) 
	and a close request of the window (on mouse up as an example).
	used to not close a window immediately after its opening (menu).
	nil means no autoclosing.
	"

	autoCloseDelay := aDelay ifNotNil: [ :d | d asDuration ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> canCloseWindowAfter: aTimestamp [

	| delay |

	aTimestamp ifNil: [ ^ true ].
	currentWindow ifNil: [ ^ true ].	
	currentWindow popupTimestamp ifNil: [ ^ true ].	
	autoCloseDelay ifNil: [ ^ true ].

	delay := aTimestamp - currentWindow popupTimestamp.
	delay >= autoCloseDelay ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
ToPopupWindowManager >> checkOutsideEvent: aBoolean [

	checkOutsideEvent := aBoolean
]

{ #category : #accessing }
ToPopupWindowManager >> checkPickOutside: aBoolean [

	self
		deprecated: 'Use #checkOutsideEvent instead'
		transformWith:
		'`@rcvr checkPickOutside: `@arg'
		-> '`@rcvr checkOutsideEvent: `@arg'.

	self checkOutsideEvent: aBoolean
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnLeaved: aBoolean [

	closeOnLeaved := aBoolean 
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnReleased: aBoolean [

	closeOnReleased := aBoolean 
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindowIfMinimumDelayExceededOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	anEvent ifNotNil: [
			(self isMinimumDelayBeforeClosingExceededOnEvent: anEvent) ifFalse: [
					self resetPopupHandlerOnEvent: anEvent.
					^ self ] ].
	self closeWindowNowOnEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindowNowOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	anEvent ifNotNil: [
		self consumeEventAfterForcedClosing ifTrue: [ anEvent consume ] ].
	anchorRoot ifNotNil: [ :ar | self closeWindowOnEvent: anEvent ]
]

{ #category : #'event handling' }
ToPopupWindowManager >> consumeEventAfterForcedClosing [

	^ true
]

{ #category : #initialization }
ToPopupWindowManager >> defaultAutoCloseDelay [
	" automatically close the window if the delay between the popup 
	and an event (mouse-up) is greater than this delay"

	^ 300 milliSeconds
]

{ #category : #initialization }
ToPopupWindowManager >> defaultPlacement [

	^ ToAnchoredBottomCenterPlacement new
]

{ #category : #initialization }
ToPopupWindowManager >> defaultPopupDelay [
	" popup the window after this delay "

	^ 0 milliSeconds
]

{ #category : #initialization }
ToPopupWindowManager >> defaultWindowStarter [

	^ ToStandardPopupStarter new
]

{ #category : #'api - accessing' }
ToPopupWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  ToMouseUpOutsideEvent.
		  ToMouseOutsideEvent.
		  ToStartStillHoveredEvent.
		  ToStopStillHoveredEvent.
		  ToStartStillPressedEvent.
		  ToStopStillPressedEvent.
		  BlMouseUpEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton.
 	autoCloseDelay := self defaultAutoCloseDelay.
	checkOutsideEvent := true.
	popupDelay := self defaultPopupDelay.
	closeOnReleased := false.
	closeOnLeaved := false.
	popupOnPressed := true.
	popover := false

]

{ #category : #initialization }
ToPopupWindowManager >> installOutsideEventFilter [

	outsideEventFilter ifNotNil: [ ^ self ].
	outsideEventFilter := self newOutsideEventFilter.
	anchorElement space root addEventFilter: outsideEventFilter.
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseEnterEvent: anEvent [


]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseLeaveEvent: anEvent [

	closeOnLeaved ifFalse: [ ^ self ].
	self closeWindowIfMinimumDelayExceededOnEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseOutsideEvent: anEvent [

	anEvent emitter = outsideEventFilter ifFalse: [ ^ self ].
	checkOutsideEvent ifFalse: [ ^ self ].
	popover ifFalse: [ closeOnLeaved ifFalse: [ ^ self ] ].
	anEvent sourceEvent consume.
	self onOutsideEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [

	self closeWindowIfMinimumDelayExceededOnEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpOutsideEvent: anEvent [

	anEvent emitter = outsideEventFilter ifFalse: [ ^ self ].
	checkOutsideEvent ifFalse: [ ^ self ].
	anEvent sourceEvent consume.
	self onOutsideEvent: anEvent
]

{ #category : #initialization }
ToPopupWindowManager >> newDelayedPopupHandler [
	
	^ ToMixedEventGeneratorHandler new
]

{ #category : #initialization }
ToPopupWindowManager >> newOutsideEventFilter [

	^ ToOutsideEventFilter new
		  eventsToHandle: (popover
				   ifTrue: [
						   {
							   BlMouseOverEvent.
							   BlMouseUpEvent } ]
				   ifFalse: [ { BlMouseUpEvent } ]);
		  element: anchorElement;
		  yourself
]

{ #category : #'api - hooks' }
ToPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	delayedPopupHandler := self newDelayedPopupHandler.
	delayedPopupHandler startDelay: self popupDelay.
	delayedPopupHandler activateOnPressed: popupOnPressed.
	delayedPopupHandler activateOnHovered: popover.
	delayedPopupHandler standaloneMouseOutsideFilter: false.
	anchorElement addEventHandler: delayedPopupHandler
]

{ #category : #'event handling' }
ToPopupWindowManager >> onOutsideEvent: anEvent [

	self closeWindowIfMinimumDelayExceededOnEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> onWindowClosedOnEvent: anEvent [

	super onWindowClosedOnEvent: anEvent.
	self resetPopupHandlerOnEvent: anEvent.
	self uninstallOutsideEventFilter.
]

{ #category : #'window handling' }
ToPopupWindowManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	self installOutsideEventFilter
]

{ #category : #accessing }
ToPopupWindowManager >> popover: aBoolean [

	popover := aBoolean.
	delayedPopupHandler activateOnHovered: popover.
]

{ #category : #accessing }
ToPopupWindowManager >> popupDelay [

	^ popupDelay
]

{ #category : #accessing }
ToPopupWindowManager >> popupDelay: aDuration [

	popupDelay := aDuration.
	delayedPopupHandler startDelay: self popupDelay.
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	anchorElement isEnabled ifFalse: [ ^ self ].
	self createNewWindowOnEvent: anEvent.
	currentWindow popupEvent: anEvent.
	anEvent ifNotNil: [ :evt | evt consume ]
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnPressed: aBoolean [
	" useful for tablet UI "

	popupOnPressed := aBoolean.
	delayedPopupHandler activateOnPressed: popupOnPressed
]

{ #category : #'window handling' }
ToPopupWindowManager >> requestCloseWindowOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	(self canCloseWindowAfter: anEvent timestamp) ifFalse: [ ^ self ].
	self closeWindowIfMinimumDelayExceededOnEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> resetPopupHandlerOnEvent: anEvent [

	delayedPopupHandler resetTaskFromEvent: anEvent in: anchorElement
]

{ #category : #'event handling' }
ToPopupWindowManager >> startStillHoveredEvent: anEvent [
	" first I have to test if I'am concerned by this event "

	anEvent emitter = delayedPopupHandler ifFalse: [ ^ self ].
	self popupEvent: anEvent sourceEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> startStillPressedEvent: anEvent [
	" first I have to test if I'am concerned by this event "

	anEvent emitter = delayedPopupHandler ifFalse: [ ^ self ].
	anEvent sourceEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [ ^ self ].
	self popupEvent: anEvent sourceEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillHoveredEvent: anEvent [

	closeOnLeaved ifFalse: [ ^ self ].
	self requestCloseWindowOnEvent: anEvent sourceEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillPressedEvent: anEvent [

	closeOnReleased ifFalse: [ ^ self ].
	self requestCloseWindowOnEvent: anEvent sourceEvent
]

{ #category : #initialization }
ToPopupWindowManager >> uninstallOutsideEventFilter [

	outsideEventFilter ifNil: [ ^ self ].
	anchorElement isAttachedToSceneGraph ifTrue: [
		anchorElement space root removeEventFilter: outsideEventFilter ].
	outsideEventFilter := nil
]

{ #category : #initialization }
ToPopupWindowManager >> useNoMouseButton [

	mouseButton := nil
]

{ #category : #initialization }
ToPopupWindowManager >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #initialization }
ToPopupWindowManager >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
