Class {
	#name : #ToTooltipManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToTooltipManager >> consumeEventAfterForcedClosing [

	^ false
]

{ #category : #initialization }
ToTooltipManager >> defaultPlacement [

	^ ToTooltipPlacement new
]

{ #category : #initialization }
ToTooltipManager >> defaultPopupDelay [
	" popup the window after this delay "

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipManager >> defaultWindowFactory [

	^ [ ToTooltipWindow ]
]

{ #category : #initialization }
ToTooltipManager >> initialize [

	super initialize.
	minDelayBeforeClosing := 0 milliSeconds.
	closeOnReleased := true.
	closeOnLeaved := true.
	popupOnPressed := false.
	popover := true
]

{ #category : #'event handling' }
ToTooltipManager >> mouseOutsideEvent: anEvent [

	anEvent emitter = outsideEventFilter ifFalse: [ ^ self ].
	checkOutsideEvent ifFalse: [ ^ self ].
	closeOnLeaved ifFalse: [ ^ self ].
	super mouseOutsideEvent: anEvent

]

{ #category : #'event handling' }
ToTooltipManager >> mouseUpEvent: anEvent [

	self resetPopupHandlerOnEvent: anEvent.
	closeOnReleased ifFalse: [ ^ self ].
	super mouseUpEvent: anEvent
]
