Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'popupOnMouseEnter',
		'popupDelay',
		'delayedPopupTask',
		'pickOutsideFilter',
		'autoCloseDelay',
		'upCountRequired'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay [

	^ autoCloseDelay ifNil: [ autoCloseDelay:= self defaultAutoCloseDelay ]
]

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay: aDelay [

	autoCloseDelay := aDelay ifNotNil: [:d| d asDuration ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> autoCloseWindow [ 

	self closeWindow
]

{ #category : #accessing }
ToPopupWindowManager >> autoPopupDelay: aDuration [

	element addEventHandler: (ToStillHoveredEventHandler new
			 startDelay: aDuration;
			 yourself).
	element addEventHandlerOn: ToStartStillHoveredEvent do: [ :event |
		event consume.
		self popupEvent: event ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> checkAutoCloseWindowOnMouseUp: anEvent [

	| delay |
	currentWindow ifNil: [ ^ false ].
	currentWindow popupTimestamp ifNil: [ ^ false ].
	autoCloseDelay ifNil: [ ^ false ].
	delay := anEvent timestamp - currentWindow popupTimestamp.
	delay > autoCloseDelay ifFalse: [ ^ false ].
	anEvent consume.
	self autoCloseWindow.
	^ true
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindow [ 

	self unqueuePopupTaskIn: element.
	super closeWindow.

]

{ #category : #initialization }
ToPopupWindowManager >> defaultAutoCloseDelay [

	^ 300 milliSeconds
]

{ #category : #accessing }
ToPopupWindowManager >> defaultPopupDelay [

	^ 0 milliSeconds
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
		  BlMouseEnterEvent.
		  ToPickOutsideEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
	popupDelay := self defaultPopupDelay.
 	autoCloseDelay := self defaultAutoCloseDelay.
	popupOnMouseEnter := false
]

{ #category : #'window handling' }
ToPopupWindowManager >> installPickOutsideFilter [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := self newPickOutsideFilter.
	element space root addEventFilter: pickOutsideFilter.
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseDownEvent: anEvent [

	builder ifNil: [ ^ self ].
	self unqueuePopupTaskIn: element.
	anEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [
		currentWindow isOpened ifTrue: [ self closeWindow ].
		^ self ].
	self popupOnMouseDown ifFalse: [ ^ self ].
	currentWindow ifNotNil: [ ^ self ].
	self popupEvent: anEvent delay: 0 milliSeconds.
	anEvent consume
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseEnterEvent: anEvent [

	popupOnMouseEnter ifFalse: [ ^ self ].
	self unqueuePopupTaskIn: anEvent currentTarget.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self popupEvent: anEvent
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

{ #category : #accessing }
ToPopupWindowManager >> popupDelay [

	^ popupDelay 
]

{ #category : #accessing }
ToPopupWindowManager >> popupDelay: aDuration [

	popupDelay := aDuration
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupEvent: anEvent [

	upCountRequired := 1.
	self popupEvent: anEvent delay: popupDelay
]

{ #category : #'window handling' }
ToPopupWindowManager >> popupEvent: anEvent delay: aDelay [

	currentWindow ifNotNil: [ ^ self ].
	delayedPopupTask ifNotNil: [
		element dequeueTask: delayedPopupTask.
		delayedPopupTask := nil ].
	element isEnabled ifFalse: [ ^ self ].
	aDelay isZero ifTrue: [ ^ self popupNewWindowEvent: anEvent ].
	delayedPopupTask := BlDelayedTaskAction new.
	delayedPopupTask
		delay: aDelay;
		action: [
			self popupNewWindowEvent: anEvent.
			delayedPopupTask := nil ].
	element enqueueTask: delayedPopupTask
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

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseEnter: aBoolean [

	popupOnMouseEnter := aBoolean
]

{ #category : #'window handling' }
ToPopupWindowManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	element space ifNil: [ ^ self ].
	element space root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.

]

{ #category : #'window handling' }
ToPopupWindowManager >> unqueuePopupTaskIn: anElement [

	delayedPopupTask ifNotNil: [ 
		anElement dequeueTask: delayedPopupTask.
		delayedPopupTask := nil ]
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
