Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'pickOutsideFilter',
		'autoCloseDelay',
		'upCountRequired',
		'autoPopupHandler'
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

	autoCloseDelay := aDelay ifNotNil: [:d| d asDuration ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> autoCloseWindow [ 

	self closeWindow
]

{ #category : #accessing }
ToPopupWindowManager >> autoPopupDelay: aDuration [

	autoPopupHandler
		ifNil: [
			autoPopupHandler := ToStillHoveredEventHandler new
				                    startDelay: aDuration;
				                    yourself.
			element addEventHandler: autoPopupHandler ]
		ifNotNil: [ autoPopupHandler startDelay: aDuration ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> checkAutoCloseWindowAfter: aTimestamp [

	| delay |
	currentWindow ifNil: [ ^ false ].
	currentWindow popupTimestamp ifNil: [ ^ false ].
	autoCloseDelay ifNil: [ ^ false ].
	delay := aTimestamp - currentWindow popupTimestamp.
	delay > autoCloseDelay ifFalse: [ ^ false ].
	self autoCloseWindow.
	^ true
]

{ #category : #'window handling' }
ToPopupWindowManager >> checkAutoCloseWindowOnMouseUp: anEvent [

	(self checkAutoCloseWindowAfter: anEvent timestamp) ifTrue: [
		anEvent consume ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindow [ 

	self unqueuePopupTaskFromEvent: nil.
	super closeWindow.

]

{ #category : #initialization }
ToPopupWindowManager >> defaultAutoCloseDelay [
	" automatically close the window if the delay between the popup 
	and an event (mouse-up) is greater than this delay"

	^ 300 milliSeconds
]

{ #category : #initialization }
ToPopupWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]

{ #category : #'api - accessing' }
ToPopupWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  ToPickOutsideEvent.
		  ToStartStillHoveredEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
 	autoCloseDelay := self defaultAutoCloseDelay
]

{ #category : #'window handling' }
ToPopupWindowManager >> installPickOutsideFilter [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := self newPickOutsideFilter.
	element space root addEventFilter: pickOutsideFilter.
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseDownEvent: anEvent [

	windowBuilder ifNil: [ ^ self ].
	self unqueuePopupTaskFromEvent: anEvent.
	anEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [
		self closeWindow.
		^ self ].
	self popupOnMouseDown ifFalse: [ ^ self ].
	currentWindow ifNotNil: [ ^ self ].
	self popupEvent: anEvent.
	anEvent consume
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [

	self checkAutoCloseWindowOnMouseUp: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> newPickOutsideFilter [

	^ ToPopupPickOutsideEventFilter new
		  windowManager: self;
		  upCountRequired: upCountRequired;
		  yourself
]

{ #category : #'window handling' }
ToPopupWindowManager >> onClosed [

	self uninstallPickOutsideFilter.
	super onClosed
]

{ #category : #'window handling' }
ToPopupWindowManager >> onOpened [ 

	super onOpened.
	self installPickOutsideFilter 
]

{ #category : #'event handling' }
ToPopupWindowManager >> pickOutsideEvent: anEvent [

	self currentWindowDo: [ :w | w close ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	element isEnabled ifFalse: [ ^ self ].
	upCountRequired := 1.
	self popupNewWindowEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupNewWindowEvent: anEvent [

	| w |
	w := self newWindowEvent: anEvent.
	w popupEvent: anEvent
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseDown [

	^ true
]

{ #category : #'still pressed - hovered' }
ToPopupWindowManager >> startStillHoveredEvent: anEvent [
	" test if I'am concerned by this event "
	anEvent sourceHandler = autoPopupHandler ifFalse: [ ^ self ].
	self popupEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	element space ifNil: [ ^ self ].
	element space root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.

]

{ #category : #'window handling' }
ToPopupWindowManager >> unqueuePopupTaskFromEvent: anEvent [

	autoPopupHandler ifNil: [ ^ self ].
	autoPopupHandler stopTaskFromEvent: anEvent in: element
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

{ #category : #accessing }
ToPopupWindowManager >> windowClass [

	^ ToPopupWindow 
]
