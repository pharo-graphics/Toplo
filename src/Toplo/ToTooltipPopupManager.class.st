Class {
	#name : #ToTooltipPopupManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'closeOnMouseLeave'
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

	^ super eventsToHandle , { BlMouseLeaveEvent. BlMouseUpEvent }
]

{ #category : #initialization }
ToTooltipPopupManager >> initialize [

	super initialize.
	self closeOnMouseLeave: true.
	upCountRequired := 0.
	popupOnPressed := false.
	popupOnHovered := true
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseLeaveEvent: anEvent [

	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseUpEvent: anEvent [


	"windowBuilder ifNil: [ ^ self ]."
	self unqueuePopupTaskFromEvent: anEvent.
	self closeWindow
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnPressed [

	^ popupOnPressed
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnPressed: aBoolean [
	" useful for tablet UI "


	"windowBuilder ifNil: [ ^ self ]."
	self unqueuePopupTaskFromEvent: anEvent.
	delayedPopupHandler reset.
	self closeWindow
]

{ #category : #accessing }
ToTooltipPopupManager >> popupWindowClass [

	^ ToTooltipWindow 
]
