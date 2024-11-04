Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'autoCloseOnMouseUpDelay',
		'mouseButton',
		'popupDelay',
		'popupOnMouseEnter',
		'closeOnMouseLeave',
		'closeOnMouseDown',
		'popupOnMouseDown',
		'delayedPopupTask'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay [

	^ autoCloseOnMouseUpDelay
]

{ #category : #accessing }
ToPopupWindowManager >> autoCloseDelay: aDelay [

	autoCloseOnMouseUpDelay := aDelay ifNotNil: [:d| d asDuration ]
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
ToPopupWindowManager >> enqueuePopupTaskFromEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	element isEnabled ifFalse: [ ^ self ].
	popupDelay isZero ifTrue: [
		(self newWindowEvent: anEvent) popupEvent: anEvent.
		^ self ].
	delayedPopupTask := BlDelayedTaskAction new
		                    delay: popupDelay;
		                    action: [
			                    (self newWindowEvent: anEvent) popupEvent:
					                    anEvent.
			                    delayedPopupTask := nil ].
	element enqueueTask: delayedPopupTask
]

{ #category : #'api - accessing' }
ToPopupWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseUpOutsideEvent }
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
	popupDelay := self defaultPopupDelay.
 	autoCloseOnMouseUpDelay := self defaultAutoCloseDelay.
	popupOnMouseEnter := false.
	closeOnMouseLeave := false.
	popupOnMouseDown := true.
	closeOnMouseDown := true
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
	" currentWindow can be nil in case the element is disabled "

]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseDownOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
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

	| delay maxDelay |
	currentWindow ifNil: [ ^ self ].
	currentWindow popupTimestamp ifNil: [ ^ self ].
	maxDelay := self autoCloseDelay.
	maxDelay ifNil: [ ^ self ].
	delay := anEvent timestamp - currentWindow popupTimestamp.
	delay > maxDelay ifFalse: [ ^ self ].
	anEvent consume.
	currentWindow close
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> pickOutsideEvent: anEvent [
	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"

	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasInParentChain: element) ifTrue: [ ^ self ].
		self currentWindowDo: [ :w |
			(originalTarget hasInParentChain: w) ifTrue: [ ^ self ] ] ].

	" ok, mouseUp outside the element and outside of the popup window "
	self currentWindowDo: [ :w |
		"anEvent consume."
		w close ]
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
ToPopupWindowManager >> popupOnMouseEnter [

	^ popupOnMouseEnter 
]

{ #category : #accessing }
ToPopupWindowManager >> popupOnMouseEnter: aBoolean [

	popupOnMouseEnter := aBoolean
]

{ #category : #'event handling' }
ToPopupWindowManager >> popupWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToPopupWindowManager >> popupWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
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
