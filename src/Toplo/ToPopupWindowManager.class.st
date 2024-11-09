Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'popupDelay',
		'popupOnMouseEnter',
		'closeOnMouseLeave',
		'closeOnMouseDown',
		'popupOnMouseDown',
		'delayedPopupTask',
		'pickOutsideFilter',
		'autoCloseDelay'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay [

	^ autoCloseDelay
]

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay: aDelay [

	autoCloseDelay := aDelay ifNotNil: [:d| d asDuration ]
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseDown [

	^ closeOnMouseDown
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseLeave [

	^ closeOnMouseLeave
]

{ #category : #accessing }
ToPopupWindowManager >> closeOnMouseLeave: aBoolean [

	closeOnMouseLeave := aBoolean
]

{ #category : #'window handling' }
ToPopupWindowManager >> closeWindow [ 

	self unqueuePopupTaskIn: element.
	super closeWindow.

]

{ #category : #'event handling' }
ToPopupWindowManager >> contextMenuRequest: anEvent [
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

{ #category : #'window handling' }
ToPopupWindowManager >> doPopupFromEvent: anEvent [

	| w |
	w := self newWindowEvent: anEvent.
	w popupEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> enqueuePopupTaskFromEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	element isEnabled ifFalse: [ ^ self ].
	popupDelay isZero ifTrue: [
		self doPopupFromEvent: anEvent.
		^ self ].
	delayedPopupTask := BlDelayedTaskAction new
		                    delay: popupDelay;
		                    action: [
			                    self doPopupFromEvent: anEvent.
			                    delayedPopupTask := nil ].
	element enqueueTask: delayedPopupTask
]

{ #category : #'api - accessing' }
ToPopupWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
	popupDelay := self defaultPopupDelay.
 	autoCloseDelay := self defaultAutoCloseDelay.
	popupOnMouseEnter := false.
	closeOnMouseLeave := false.
	popupOnMouseDown := true.
	closeOnMouseDown := true
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
	closeOnMouseDown ifTrue: [ self unqueuePopupTaskIn: element ].
	anEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [
		closeOnMouseDown ifTrue: [
			currentWindow isOpened ifTrue: [ currentWindow close ].
			^ self ] ].
	popupOnMouseDown ifFalse: [ ^ self ].
	currentWindow ifNotNil: [ ^ self ].

	self enqueuePopupTaskFromEvent: anEvent.
	anEvent consume
	" currentWindow can be nil in case the element is disabled "

]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseEnterEvent: anEvent [

	popupOnMouseEnter ifFalse: [ ^ self ].
	self unqueuePopupTaskIn: anEvent currentTarget.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self enqueuePopupTaskFromEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseLeaveEvent: anEvent [

	self unqueuePopupTaskIn: anEvent currentTarget.
	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [

	| delay |
	currentWindow ifNil: [ ^ self ].
	currentWindow popupTimestamp ifNil: [ ^ self ].
	autoCloseDelay ifNil: [ ^ self ].
	delay := anEvent timestamp - currentWindow popupTimestamp.
	delay > autoCloseDelay ifFalse: [ ^ self ].
	anEvent consume.
	currentWindow close
]

{ #category : #'window handling' }
ToPopupWindowManager >> newPickOutsideFilter [

	^ ToPopupPickOutsideEventFilter new
		  windowManager: self;
		  yourself
]

{ #category : #accessing }
ToPopupWindowManager >> popupDelay [

	^ popupDelay 
]

{ #category : #accessing }
ToPopupWindowManager >> popupDelay: aDuration [

	popupDelay := aDuration asDuration
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseDown [

	^ popupOnMouseDown 
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseEnter [

	^ popupOnMouseEnter 
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseEnter: aBoolean [

	popupOnMouseEnter := aBoolean
]

{ #category : #'event handling' }
ToPopupWindowManager >> popupWindowClosedEvent: anEvent [

	self uninstallPickOutsideFilter.
	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> popupWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent.
	self installPickOutsideFilter 
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

{ #category : #accessing }
ToPopupWindowManager >> windowClosedEventClass [

	^ ToPopupWindowClosedEvent
]

{ #category : #accessing }
ToPopupWindowManager >> windowOpenedEventClass [

	^ ToPopupWindowOpenedEvent
]
