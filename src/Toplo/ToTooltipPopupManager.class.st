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

{ #category : #initialization }
ToTooltipPopupManager >> initialize [

	super initialize.
	closeOnMouseReleased := true.
	closeOnMouseLeaved := true.
	popupOnPressed := false.
	popupOnHovered := true
]

{ #category : #accessing }
ToTooltipPopupManager >> popupWindowClass [

	^ ToTooltipWindow 
]
