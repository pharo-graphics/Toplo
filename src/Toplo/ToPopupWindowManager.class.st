Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'mouseButton',
		'pickOutsideFilter',
		'autoCloseDelay',
		'upCountRequired',
		'autoPopupHandler',
		'checkPickOutside',
		'closeOnPicking'
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
			anchorElement addEventHandler: autoPopupHandler ]
		ifNotNil: [ autoPopupHandler startDelay: aDuration ]
]

{ #category : #'window handling' }
ToPopupWindowManager >> beInline [ 

	super beInline.
	self unplugPickOutsideFilter
]

{ #category : #'event handling' }
ToPopupWindowManager >> canCloseOnPickingEvent: anEvent [

	currentWindow ifNotNil: [ closeOnPicking ifTrue: [ ^ true ] ].
	^ false
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

	anEvent consume.
	(self canCloseWindowAfter: anEvent timestamp) ifFalse: [ ^ self ].
	self autoCloseWindow.

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
	self unqueuePopupTaskFromEvent: nil.
	super closeWindow.
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
 	autoCloseDelay := self defaultAutoCloseDelay.
	closeOnPicking := self defaultCloseOnPicking.
	checkPickOutside := true
]

{ #category : #'window handling' }
ToPopupWindowManager >> installPickOutsideFilter [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := self newPickOutsideFilter.
	anchorElement space root addEventFilter: pickOutsideFilter.
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseDownEvent: anEvent [

	windowBuilder ifNil: [ ^ self ].

	self unqueuePopupTaskFromEvent: anEvent.
	anEvent button = mouseButton ifFalse: [ ^ self ].
	(self canCloseOnPickingEvent: anEvent) ifTrue: [
		self closeWindow.
		^ self ].
	self popupOnMouseDown ifFalse: [ ^ self ].
	currentWindow ifNotNil: [ ^ self ].
	self popupEvent: anEvent.
	anEvent consume
]

{ #category : #'event handling' }
ToPopupWindowManager >> mouseUpEvent: anEvent [
	
	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnPickingEvent: anEvent
]

{ #category : #'window handling' }
ToPopupWindowManager >> newPickOutsideFilter [

	^ self pickOutsideFilterClass new
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
	checkPickOutside ifFalse: [
		self uninstallPickOutsideFilter.
		^ self ].
	self installPickOutsideFilter
]

{ #category : #'event handling' }
ToPopupWindowManager >> pickOutsideEvent: anEvent [

	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnPickingEvent: anEvent
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

{ #category : #'window handling' }
ToPopupWindowManager >> popupEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	anchorElement isEnabled ifFalse: [ ^ self ].
	upCountRequired := 1.
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
ToPopupWindowManager >> popupOnMouseDown [

	^ true
]

{ #category : #'still pressed - hovered' }
ToPopupWindowManager >> startStillHoveredEvent: anEvent [
	" test if I'am concerned by this event "

	anEvent emitter = autoPopupHandler ifFalse: [ ^ self ].
	self popupEvent: anEvent
]

{ #category : #'window handling' }
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

	autoPopupHandler ifNil: [ ^ self ].
	autoPopupHandler stopTaskFromEvent: anEvent in: anchorElement
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
