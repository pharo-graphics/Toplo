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

{ #category : #accessing }
ToTooltipPopupManager >> defaultAutoPopupDelay [

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipPopupManager >> defaultCloseOnPicking [

	^ false
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
	self useNoMouseButton.
	closeOnMouseLeave := true.
]

{ #category : #'event handling' }
ToTooltipPopupManager >> mouseLeaveEvent: anEvent [

	self unqueuePopupTaskFromEvent: anEvent.
	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #'api - hooks' }
ToTooltipPopupManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self autoPopupDelay: self defaultAutoPopupDelay 
	 
]

{ #category : #accessing }
ToTooltipPopupManager >> popupOnMouseDown [

	^ false
]

{ #category : #accessing }
ToTooltipPopupManager >> popupWindowClass [

	^ ToTooltipWindow 
]
