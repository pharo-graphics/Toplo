Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'pickOutsideFilter',
		'popupDelay',
		'autoCloseDelay',
		'checkPickOutside',
		'delayedPopupHandler',
		'popupOnPressed',
		'popupOnHovered',
		'minDelayBeforeClosing',
		'closeOnLeaved',
		'closeOnReleased'
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
ToPopupWindowManager >> beInline [ 
	" for inline windows/ menus"
	windowStarter := self newInlineWindowStarter.
	checkPickOutside := false.
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

{ #category : #'window handling' }
ToPopupWindowManager >> checkCloseWindowOnEvent: anEvent [

	currentWindow ifNotNil: [
			anEvent ifNotNil: [
					(self isMinimumDelayExceededOnEvent: anEvent) ifFalse: [ ^ self ].
					self consumeEventAfterForcedClosing ifTrue: [ anEvent consume ] ] ].

	" enqueue a task to close the window. It is to ensure that the possible 
	linked actions are runned *** before *** the window is closed "
	anchorRoot ifNotNil: [ :ar |
			ar enqueueTask:
				(BlTaskAction new action: [ self closeWindowOnEvent: anEvent ]) ]
]

{ #category : #accessing }
ToPopupWindowManager >> checkPickOutside [

	^ checkPickOutside
]

{ #category : #accessing }
ToPopupWindowManager >> checkPickOutside: aBoolean [

	checkPickOutside := aBoolean
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnLeaved: aBoolean [

	closeOnLeaved := aBoolean 
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseLeaved: aBoolean [

	self
		deprecated: 'Use #CloseOnLeaved'
		transformWith:
		'`@rcvr closeOnMouseLeaved: `@arg' -> '`@rcvr closeOnLeaved: `@arg'.
	self closeOnLeaved: aBoolean
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseReleased: aBoolean [

	self
		deprecated: 'Use #closeOnReleased:'
		transformWith: '`@rcvr closeOnMouseReleased: `@arg'
			-> '`@rcvr closeOnReleased: `@arg'.
	self closeOnReleased: aBoolean
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnReleased: aBoolean [

	closeOnReleased := aBoolean 
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindowOnEvent: anEvent [

	self resetPopupHandlerOnEvent: anEvent.
	self uninstallPickOutsideFilter.
	super closeWindowOnEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> closedEvent: anEvent [

	super closedEvent: anEvent.
	self resetPopupHandlerOnEvent: anEvent.
	self uninstallPickOutsideFilter.
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
		  ToStartStillHoveredEvent.
		  ToStopStillHoveredEvent.
		  ToStartStillPressedEvent.
		  ToStopStillPressedEvent.
		  BlMouseUpEvent.
		  BlMouseLeaveEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton.
 	autoCloseDelay := self defaultAutoCloseDelay.
	minDelayBeforeClosing := 300 milliSeconds.
	checkPickOutside := true.
	popupDelay := self defaultPopupDelay.
	closeOnReleased := false.
	closeOnLeaved := false.
	popupOnPressed := true.
	popupOnHovered := false

]

{ #category : #accessing }
ToPopupWindowManager >> inlineWindowClass [

	^ ToInlineWindowElement 
]

{ #category : #initialization }
ToPopupWindowManager >> installPickOutsideFilter [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := self newPickOutsideFilter.
	anchorElement space root addEventFilter: pickOutsideFilter.
]

{ #category : #'window handling' }
ToPopupWindowManager >> isMinimumDelayExceededAfter: aTimeStamp [

	| delay |
	currentWindow ifNil: [ ^ true ].
	aTimeStamp ifNil: [ ^ true ].
	" check a minimum delay between opening and closing - 
	useful to not close immediately context menu on mouse up"
	delay := aTimeStamp - currentWindow popupTimestamp.
	^ delay > minDelayBeforeClosing
]

{ #category : #'window handling' }
ToPopupWindowManager >> isMinimumDelayExceededOnEvent: anEvent [

	^ self isMinimumDelayExceededAfter: anEvent timestamp
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseLeaveEvent: anEvent [

	closeOnLeaved ifFalse: [ ^ self ].
	" use uncheck version to not cancel auto-open "
	self uncheckCloseWindowOnEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [

	closeOnReleased ifFalse: [ ^ self ].
	self checkCloseWindowOnEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpOutsideEvent: anEvent [

	checkPickOutside ifFalse: [ ^ self ].
	anEvent sourceEvent consume.
	self onMouseUpOutsideEvent: anEvent
]

{ #category : #initialization }
ToPopupWindowManager >> newDelayedPopupHandler [
	
	^ ToMixedEventGeneratorHandler new
]

{ #category : #'window handling' }
ToPopupWindowManager >> newInlineWindowStarter [

	^ ToInlineWindowStarter new
]

{ #category : #initialization }
ToPopupWindowManager >> newPickOutsideFilter [

	^ self pickOutsideFilterClass new
		  element: anchorElement;
		  manager: self;
		  yourself
]

{ #category : #'api - hooks' }
ToPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	delayedPopupHandler := self newDelayedPopupHandler.
	delayedPopupHandler startDelay: self popupDelay.
	delayedPopupHandler activateOnPressed: popupOnPressed.
	delayedPopupHandler activateOnHovered: popupOnHovered.
	delayedPopupHandler standaloneMouseOutsideFilter: false.
	anchorElement addEventHandler: delayedPopupHandler
]

{ #category : #'event handling' }
ToPopupWindowManager >> onMouseUpOutsideEvent: anEvent [

	self checkCloseWindowOnEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> onWindowOpened [

	super onWindowOpened.
	self installPickOutsideFilter
]

{ #category : #initialization }
ToPopupWindowManager >> pickOutsideFilterClass [

	^ ToPopupMouseUpOutsideEventFilter
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
ToPopupWindowManager >> popupOnHovered [

	^ popupOnHovered
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnHovered: aBoolean [

	popupOnHovered := aBoolean.
	delayedPopupHandler activateOnHovered: self popupOnHovered.
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnPressed [

	^ popupOnPressed
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnPressed: aBoolean [
	" useful for tablet UI "

	popupOnPressed := aBoolean.
	delayedPopupHandler activateOnPressed: self popupOnPressed
]

{ #category : #'window handling' }
ToPopupWindowManager >> requestCloseWindowOnEvent: anEvent [

	(self canCloseWindowAfter: anEvent timestamp) ifFalse: [ ^ self ].
	self checkCloseWindowOnEvent: anEvent
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
	currentWindow ifNil: [ ^ self popupEvent: anEvent sourceEvent ].
	self hasInlineWindow ifTrue: [ currentWindow close ]
]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillHoveredEvent: anEvent [
]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillPressedEvent: anEvent [

	self hasInlineWindow ifTrue: [ ^ self ].
	self requestCloseWindowOnEvent: anEvent sourceEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> uncheckCloseWindowOnEvent: anEvent [

	currentWindow ifNotNil: [
			anEvent ifNotNil: [
				self consumeEventAfterForcedClosing ifTrue: [ anEvent consume ] ] ].

	" enqueue a task to close the window. It is to ensure that the possible 
	linked actions are runned *** before *** the window is closed "
	anchorRoot ifNotNil: [ :ar |
			ar enqueueTask:
				(BlTaskAction new action: [ self closeWindowOnEvent: anEvent ]) ]
]

{ #category : #initialization }
ToPopupWindowManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter stop.
	pickOutsideFilter := nil.

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
