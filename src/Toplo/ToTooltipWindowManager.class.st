Class {
	#name : #ToTooltipWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'closeOnMouseLeave'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindowManager >> closeOnMouseLeave: aBoolean [

	closeOnMouseLeave := aBoolean
]

{ #category : #accessing }
ToTooltipWindowManager >> defaultAutoPopupDelay [

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipWindowManager >> defaultCloseOnPicking [

	^ false
]

{ #category : #initializing }
ToTooltipWindowManager >> defaultPlacement [

	^ ToTooltipPlacement new
]

{ #category : #'api - accessing' }
ToTooltipWindowManager >> eventsToHandle [

	^ super eventsToHandle , { BlMouseLeaveEvent }
]

{ #category : #initialization }
ToTooltipWindowManager >> initialize [

	super initialize.
	self useNoMouseButton.
	closeOnMouseLeave := true.
]

{ #category : #'event handling' }
ToTooltipWindowManager >> mouseLeaveEvent: anEvent [

	self unqueuePopupTaskFromEvent: anEvent.
	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #'api - hooks' }
ToTooltipWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self autoPopupDelay: self defaultAutoPopupDelay 
	 
]

{ #category : #accessing }
ToTooltipWindowManager >> popupOnMouseDown [

	^ false
]

{ #category : #accessing }
ToTooltipWindowManager >> popupWindowClass [

	^ ToTooltipWindow 
]
