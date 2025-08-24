Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'pickOutsideFilter',
		'popupDelay',
		'autoCloseDelay',
		'checkPickOutside',
		'closeOnPicking',
		'delayedPopupHandler',
		'popupOnPressed',
		'popupOnHovered',
		'closeOnMouseReleased',
		'closeOnMouseLeaved',
		'minClickOutsideDelay'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'window handling' }
ToPopupWindowManager >> allowPickOutside [

	checkPickOutside := true
]

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
ToPopupWindowManager >> canCloseWindow [

	self flag: 'Keep it for now. To be checked if it is useful '.
	^ true. "pickOutsideFilter isNil or: [ pickOutsideFilter isPlugged ]"
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

{ #category : #'event handling' }
ToPopupWindowManager >> canCloseWindowOnMouseDownEvent: anEvent [

	^ self closeOnPicking
]

{ #category : #'window handling' }
ToPopupWindowManager >> checkCloseWindowOnEvent: anEvent [

	(self canCloseWindowOnMouseDownEvent: anEvent) ifFalse: [ ^ self ].
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

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseLeaved: aBoolean [

	closeOnMouseLeaved := aBoolean 
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseReleased: aBoolean [

	closeOnMouseReleased := aBoolean 
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
		  ToStopStillHoveredEvent.
		  ToStartStillPressedEvent.
		  ToStopStillPressedEvent.
		  BlMouseUpEvent.
		  BlMouseLeaveEvent }
]

{ #category : #'window handling' }
ToPopupWindowManager >> forceCloseWindowOnEvent: anEvent [

	self closeWindow.
	self consumeEventAfterForcedClosing ifTrue: [ anEvent consume ]
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton.
	minClickOutsideDelay := 300 milliSeconds.
 	autoCloseDelay := self defaultAutoCloseDelay.
	closeOnPicking := self defaultCloseOnPicking.
	checkPickOutside := true.
	popupDelay := self defaultPopupDelay.
	closeOnMouseReleased := false.
	closeOnMouseLeaved := false.
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
ToPopupWindowManager >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	" Is it ouside the element it self ? "
	(target withAllParentsInclude: anchorElement) ifTrue: [ ^ false ].

	"and outside of the popup windows ? "
	currentWindow withAllSubwindowsDo: [ :w |
		(target withAllParentsInclude: w) ifTrue: [ ^ false ] ].

	^ true
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseLeaveEvent: anEvent [

	closeOnMouseLeaved ifFalse: [ ^ self ].
	self closeWindow
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [

	closeOnMouseReleased ifFalse: [ ^ self ].
	self unqueuePopupTaskFromEvent: anEvent.
	self closeWindow
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpOutsideEvent: anEvent [

	| delay |
	checkPickOutside ifFalse: [ ^ self ].
	self isInline ifTrue: [ ^ self ].
	currentWindow ifNil: [ ^ self ].
	" check a minimum delay between opening and closing - 
	useful to not close immediately context menu on mouse up"
	delay := anEvent sourceEvent timestamp - currentWindow popupTimestamp.
	delay < minClickOutsideDelay ifTrue: [ ^ self ].
	(self isPickedOutsideEvent: anEvent sourceEvent) ifFalse: [ ^ self ].
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

{ #category : #'window handling' }
ToPopupWindowManager >> newPickOutsideFilter [

	^ self pickOutsideFilterClass new
		  element: anchorElement
		  yourself
]

{ #category : #'api - hooks' }
ToPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	delayedPopupHandler := self newDelayedPopupHandler.
	delayedPopupHandler startDelay: self popupDelay.
	delayedPopupHandler activateOnPressed: popupOnPressed.
	delayedPopupHandler activateOnHovered: popupOnHovered.

	anchorElement addEventHandler: delayedPopupHandler
]

{ #category : #'event handling' }
ToPopupWindowManager >> onMouseUpOutsideEvent: anEvent [

	self closeWindow
]

{ #category : #'window handling' }
ToPopupWindowManager >> onWindowClosed [

	self uninstallPickOutsideFilter.
	super onWindowClosed
]

{ #category : #'window handling' }
ToPopupWindowManager >> onWindowOpened [

	super onWindowOpened.
	self installPickOutsideFilter
]

{ #category : #'window handling' }
ToPopupWindowManager >> pickOutsideFilterClass [

	^ ToMouseUpOutsideEventFilter
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

{ #category : #'window handling' }
ToPopupWindowManager >> preventPickOutside [

	checkPickOutside := false
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
	currentWindow ifNil: [ ^ self popupEvent: anEvent sourceEvent copy].
	self isInline ifTrue: [ currentWindow close ].

]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillHoveredEvent: anEvent [
	
	closeOnMouseLeaved ifFalse: [ ^ self ].
	self closeWindow
]

{ #category : #'event handling' }
ToPopupWindowManager >> stopStillPressedEvent: anEvent [
	
	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnEvent: anEvent sourceEvent
]

{ #category : #initialization }
ToPopupWindowManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	anchorElement space ifNil: [ ^ self ].
	anchorElement space root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.

]

{ #category : #'window handling' }
ToPopupWindowManager >> unqueuePopupTaskFromEvent: anEvent [

	delayedPopupHandler stopTaskFromEvent: anEvent in: anchorElement.
	delayedPopupHandler reset.

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
