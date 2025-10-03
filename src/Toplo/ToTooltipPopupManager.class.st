Class {
	#name : #ToTooltipPopupManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToTooltipPopupManager >> consumeEventAfterForcedClosing [

	^ false
]

{ #category : #initialization }
ToTooltipPopupManager >> defaultPlacement [

	^ ToTooltipPlacement new
]

{ #category : #initialization }
ToTooltipPopupManager >> defaultPopupDelay [
	" popup the window after this delay "

	^ 700 milliSeconds
]

{ #category : #accessing }
ToTooltipPopupManager >> defaultWindowClass [

	^ ToTooltipWindow 
]

{ #category : #initialization }
ToTooltipPopupManager >> initialize [

	super initialize.
	minDelayBeforeClosing := 0 milliSeconds.
	closeOnReleased := true.
	closeOnLeaved := true.
	popupOnPressed := false.
	popover := true
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseOutsideEvent: anEvent [

	anEvent emitter = outsideEventFilter ifFalse: [ ^ self ].
	checkOutsideEvent ifFalse: [ ^ self ].
	closeOnLeaved ifFalse: [ ^ self ].
	super mouseOutsideEvent: anEvent

]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseUpEvent: anEvent [

	self resetPopupHandlerOnEvent: anEvent.
	closeOnReleased ifFalse: [ ^ self ].
	super mouseUpEvent: anEvent
]
