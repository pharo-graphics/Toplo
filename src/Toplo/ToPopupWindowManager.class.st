Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'pickOutsideFilter',
		'popupDelay',
		'autoCloseDelay',
		'upCountRequired',
		'checkPickOutside',
		'closeOnPicking',
		'delayedPopupHandler',
		'popupOnPressed',
		'popupOnHovered'
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
	windowStarter := ToInlineWindowStarter new.
	self unplugPickOutsideFilter
]

{ #category : #'window handling' }
ToPopupWindowManager >> canCloseWindow [

	^ pickOutsideFilter isNil or: [ pickOutsideFilter isPlugged ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> canCloseWindowAfter: aTimestamp [

	| delay |

	currentWindow ifNil: [ ^ false ].	
	currentWindow popupTimestamp ifNil: [ ^ false ].	
	autoCloseDelay ifNil: [ ^ false ].
	self canCloseWindow ifFalse: [ ^ false ].

	delay := aTimestamp - currentWindow popupTimestamp.
	delay >= autoCloseDelay ifFalse: [ ^ false ].

	^ true
]

{ #category : #'window handling' }
ToPopupWindowManager >> checkCloseWindowOnPickingEvent: anEvent [

	(self closeOnMouseDownEvent: anEvent) ifFalse: [ ^ self ].
	(self canCloseWindowAfter: anEvent timestamp) ifFalse: [ ^ self ].
	self forceCloseWindowOnEvent: anEvent
]

{ #category : #accessing }
ToPopupWindowManager >> checkPickOutside [

	^ checkPickOutside
]

{ #category : #accessing }
ToPopupWindowManager >> checkPickOutside: aBoolean [

	checkPickOutside := aBoolean
]

{ #category : #'event handling' }
ToPopupWindowManager >> closeOnMouseDownEvent: anEvent [

	^ self closeOnPicking
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnPicking [

	^ closeOnPicking 
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnPicking: aBoolean [

	closeOnPicking := aBoolean
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindow [ 

	self canCloseWindow ifFalse: [ ^ false ].
	" enqueue a task to close the window. It is to ensure that the possible 
	linked actions are runned *** before *** the window is closed "
	anchorRoot ifNotNil: [ :ar |
		ar enqueueTask: (BlTaskAction new action: [ super closeWindow ]) ].
	^ true

]

{ #category : #'window handling' }
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
ToPopupWindowManager >> defaultCloseOnPicking [

	^ true
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
ToPopupWindowManager >> defaultStarter [

	^ ToStandardPopupStarter new
]

{ #category : #'api - accessing' }
ToPopupWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  ToMouseUpOutsideEvent.
		  ToStartStillHoveredEvent.
		  ToStartStillPressedEvent.
		  ToStopStillPressedEvent }
]

{ #category : #'window handling' }
ToPopupWindowManager >> forceCloseWindowOnEvent: anEvent [

	self closeWindow.
	self consumeEventAfterForcedClosing ifTrue: [ anEvent consume ]
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
 	autoCloseDelay := self defaultAutoCloseDelay.
	closeOnPicking := self defaultCloseOnPicking.
	checkPickOutside := true.
	upCountRequired := 1.
	popupDelay := self defaultPopupDelay.
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

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpOutsideEvent: anEvent [

	anEvent emitter = pickOutsideFilter ifFalse: [ ^ self ].
	checkPickOutside ifFalse: [ ^ self ].
	self isInline ifTrue: [ ^ self ].
	self forceCloseWindowOnEvent: anEvent sourceEvent
]

{ #category : #initialization }
ToPopupWindowManager >> newDelayedPopupHandler [
	
	^ ToMixedEventGeneratorHandler new
]

{ #category : #'window handling' }
ToPopupWindowManager >> newPickOutsideFilter [

	^ self pickOutsideFilterClass new
		  element: anchorElement;
		  windowManager: self;
		  upCountRequired: upCountRequired;
		  yourself
]

{ #category : #'window handling' }
ToPopupWindowManager >> onClosed [

	self uninstallPickOutsideFilter.
	super onClosed
]

{ #category : #'api - hooks' }
ToPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	delayedPopupHandler := self newDelayedPopupHandler.
	delayedPopupHandler startDelay: self popupDelay.
	delayedPopupHandler activateOnPressed: self popupOnPressed.
	delayedPopupHandler activateOnHovered: self popupOnHovered.

	anchorElement addEventHandler: delayedPopupHandler
]

{ #category : #'window handling' }
ToPopupWindowManager >> onOpened [

	super onOpened.
	checkPickOutside ifFalse: [
		self uninstallPickOutsideFilter.
		^ self ].
	self installPickOutsideFilter
]

{ #category : #'window handling' }
ToPopupWindowManager >> pickOutsideFilterClass [

	^ ToPopupPickOutsideEventFilter
]

{ #category : #'window handling' }
ToPopupWindowManager >> plugPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter plug.

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
	self popupNewWindowEvent: anEvent.
	anEvent ifNotNil: [:evt | evt consume ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupNewWindowEvent: anEvent [

	| w |
	w := self newWindowEvent: anEvent.
	w popupEvent: anEvent
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
	windowBuilder ifNil: [ ^ self ].
	anEvent sourceEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNil: [ ^ self popupEvent: anEvent sourceEvent ].
	self isInline ifTrue: [ currentWindow close ].

]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillPressedEvent: anEvent [
	
	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnPickingEvent: anEvent sourceEvent
]

{ #category : #initialization }
ToPopupWindowManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	anchorElement space ifNil: [ ^ self ].
	anchorElement space root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.

]

{ #category : #'window handling' }
ToPopupWindowManager >> unplugPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter unplug.

]

{ #category : #'window handling' }
ToPopupWindowManager >> unqueuePopupTaskFromEvent: anEvent [

	delayedPopupHandler stopTaskFromEvent: anEvent in: anchorElement
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
