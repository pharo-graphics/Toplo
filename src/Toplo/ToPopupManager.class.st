Class {
	#name : #ToPopupManager,
	#superclass : #ToAnchoredElementManager,
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
ToPopupManager >> autoCloseDelay [
	" a minimal delay between the opening (on mouse down as an example) 
	and a close request of the window (on mouse up as an example).
	used to not close a window immediately after its opening (menu).
	nil means no autoclosing.
	"

	^ autoCloseDelay ifNil: [ autoCloseDelay:= self defaultAutoCloseDelay ]
]

{ #category : #accessing }
ToPopupManager >> autoCloseDelay: aDelay [
	" a minimal delay between the opening (on mouse down as an example) 
	and a close request of the window (on mouse up as an example).
	used to not close a window immediately after its opening (menu).
	nil means no autoclosing.
	"

	autoCloseDelay := aDelay ifNotNil: [:d| d asDuration ]
]

{ #category : #'window handling' }
ToPopupManager >> autoCloseWindow [

	self closeWindow
]

{ #category : #accessing }
ToPopupManager >> autoPopupDelay: aDuration [

	autoPopupHandler
		ifNil: [
			autoPopupHandler := ToStillHoveredEventHandler new
				                    startDelay: aDuration;
				                    yourself.
			anchorElement addEventHandler: autoPopupHandler ]
		ifNotNil: [ autoPopupHandler startDelay: aDuration ]
]

{ #category : #'window handling' }
ToPopupManager >> beInline [ 

	super beInline.
	self unplugPickOutsideFilter
]

{ #category : #'event handling' }
ToPopupManager >> canCloseOnPickingEvent: anEvent [

	currentWindow ifNotNil: [ closeOnPicking ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'window handling' }
ToPopupManager >> canCloseWindow [

	^ pickOutsideFilter isNil or: [ pickOutsideFilter isPlugged ]
]

{ #category : #'window handling' }
ToPopupManager >> canCloseWindowAfter: aTimestamp [

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
ToPopupManager >> checkCloseWindowOnPickingEvent: anEvent [

	(self canCloseWindowAfter: anEvent timestamp) ifFalse: [ ^ self ].
	self autoCloseWindow.
	anEvent consume
]

{ #category : #accessing }
ToPopupManager >> checkPickOutside [

	^ checkPickOutside
]

{ #category : #accessing }
ToPopupManager >> checkPickOutside: aBoolean [

	checkPickOutside := aBoolean
]

{ #category : #accessing }
ToPopupManager >> closeOnPicking [

	^ closeOnPicking 
]

{ #category : #accessing }
ToPopupManager >> closeOnPicking: aBoolean [

	closeOnPicking := aBoolean
]

{ #category : #'window handling' }
ToPopupManager >> closeWindow [ 

	self canCloseWindow ifFalse: [ ^ false ].
	self unqueuePopupTaskFromEvent: nil.
	super closeWindow.
	^ true

]

{ #category : #initialization }
ToPopupManager >> defaultAutoCloseDelay [
	" automatically close the window if the delay between the popup 
	and an event (mouse-up) is greater than this delay"

	^ 300 milliSeconds
]

{ #category : #initialization }
ToPopupManager >> defaultCloseOnPicking [

	^ true
]

{ #category : #initialization }
ToPopupManager >> defaultPlacement [

	^ ToAnchoredBottomCenterPlacement new
]

{ #category : #'api - accessing' }
ToPopupManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  ToPickOutsideEvent.
		  ToStartStillHoveredEvent }
]

{ #category : #initialization }
ToPopupManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton .
 	autoCloseDelay := self defaultAutoCloseDelay.
	closeOnPicking := self defaultCloseOnPicking.
	checkPickOutside := true
]

{ #category : #'window handling' }
ToPopupManager >> installPickOutsideFilter [

	pickOutsideFilter ifNotNil: [ ^ self ].
	pickOutsideFilter := self newPickOutsideFilter.
	anchorElement space root addEventFilter: pickOutsideFilter.
]

{ #category : #'event handling' }
ToPopupManager >> mouseDownEvent: anEvent [

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
ToPopupManager >> mouseUpEvent: anEvent [
	
	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnPickingEvent: anEvent
]

{ #category : #'window handling' }
ToPopupManager >> newPickOutsideFilter [

	^ self pickOutsideFilterClass new
		  windowManager: self;
		  upCountRequired: upCountRequired;
		  yourself
]

{ #category : #'window handling' }
ToPopupManager >> onClosed [

	self uninstallPickOutsideFilter.
	super onClosed
]

{ #category : #'window handling' }
ToPopupManager >> onOpened [

	super onOpened.
	checkPickOutside ifFalse: [
		self uninstallPickOutsideFilter.
		^ self ].
	self installPickOutsideFilter
]

{ #category : #'event handling' }
ToPopupManager >> pickOutsideEvent: anEvent [

	self isInline ifTrue: [ ^ self ].
	self checkCloseWindowOnPickingEvent: anEvent
]

{ #category : #'window handling' }
ToPopupManager >> pickOutsideFilterClass [

	^ ToPopupPickOutsideEventFilter
]

{ #category : #'window handling' }
ToPopupManager >> plugPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter plug.

]

{ #category : #'window handling' }
ToPopupManager >> popupEvent: anEvent [

	currentWindow ifNotNil: [ ^ self ].
	anchorElement isEnabled ifFalse: [ ^ self ].
	upCountRequired := 1.
	self popupNewWindowEvent: anEvent
]

{ #category : #'window handling' }
ToPopupManager >> popupNewWindowEvent: anEvent [

	| w |
	w := self newWindowEvent: anEvent.
	w popupEvent: anEvent
]

{ #category : #accessing }
ToPopupManager >> popupOnMouseDown [

	^ true
]

{ #category : #accessing }
ToPopupManager >> popupWindowClass [

	^ ToPopupWindow 
]

{ #category : #'still pressed - hovered' }
ToPopupManager >> startStillHoveredEvent: anEvent [
	" test if I'am concerned by this event "

	anEvent emitter = autoPopupHandler ifFalse: [ ^ self ].
	self popupEvent: anEvent
]

{ #category : #'window handling' }
ToPopupManager >> uninstallPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	anchorElement space ifNil: [ ^ self ].
	anchorElement space root removeEventFilter: pickOutsideFilter.
	pickOutsideFilter := nil.

]

{ #category : #'window handling' }
ToPopupManager >> unplugPickOutsideFilter [

	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter unplug.

]

{ #category : #'window handling' }
ToPopupManager >> unqueuePopupTaskFromEvent: anEvent [

	autoPopupHandler ifNil: [ ^ self ].
	autoPopupHandler stopTaskFromEvent: anEvent in: anchorElement
]

{ #category : #initialization }
ToPopupManager >> useNoMouseButton [

	mouseButton := nil
]

{ #category : #initialization }
ToPopupManager >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #initialization }
ToPopupManager >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
