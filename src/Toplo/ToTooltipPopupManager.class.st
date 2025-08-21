Class {
	#name : #ToTooltipPopupManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'closeOnMouseLeave',
		'popupOnPressed'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipPopupManager >> closeOnMouseLeave: aBoolean [

	closeOnMouseLeave := aBoolean
]

{ #category : #'window handling' }
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

{ #category : #'api - accessing' }
ToTooltipPopupManager >> eventsToHandle [

	^ super eventsToHandle , { BlMouseLeaveEvent }
]

{ #category : #initialization }
ToTooltipPopupManager >> initialize [

	super initialize.
	popupOnPressed := false.
	self closeOnMouseLeave: true.
	upCountRequired := 0
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseLeaveEvent: anEvent [

	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnPressed [

	^ popupOnPressed
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnPressed: aBoolean [
	" useful for tablet UI "

	popupOnPressed := aBoolean.
	self installDelayedPopupHandler
]

{ #category : #accessing }
ToTooltipPopupManager >> popupWindowClass [

	^ ToTooltipWindow 
]
