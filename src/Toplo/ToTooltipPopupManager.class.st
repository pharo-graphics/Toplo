Class {
	#name : #ToTooltipPopupManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'closeOnMouseLeave',
		'popupOnMouseDown'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipPopupManager >> closeOnMouseLeave: aBoolean [

	closeOnMouseLeave := aBoolean
]

{ #category : #accessing }
ToTooltipPopupManager >> defaultAutoPopupDelay [

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipPopupManager >> defaultPlacement [

	^ ToTooltipPlacement new
]

{ #category : #'api - accessing' }
ToTooltipPopupManager >> eventsToHandle [

	^ super eventsToHandle , { BlMouseLeaveEvent }
]

{ #category : #initialization }
ToTooltipPopupManager >> initialize [

	super initialize.
	self popupOnMouseDown: false.
	self closeOnMouseLeave: true.
	upCountRequired := 0
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseLeaveEvent: anEvent [

	self unqueuePopupTaskFromEvent: anEvent.
	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #'window handling' }
ToTooltipPopupManager >> onAutoClosedOnEvent: anEvent [
]

{ #category : #'api - hooks' }
ToTooltipPopupManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self autoPopupDelay: self defaultAutoPopupDelay 
	 
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnMouseDown [

	^ popupOnMouseDown
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnMouseDown: aBoolean [
	" useful for tablet UI "

	popupOnMouseDown := aBoolean
]

{ #category : #accessing }
ToTooltipPopupManager >> popupWindowClass [

	^ ToTooltipWindow 
]
