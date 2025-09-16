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
	minDelayAfterOpening := 0 milliSeconds.
	closeOnReleased := true.
	closeOnLeaved := true.
	popupOnPressed := false.
	popupOnHovered := true
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseUpEvent: anEvent [

	self resetPopupHandlerOnEvent: anEvent.
	super mouseUpEvent: anEvent
]
