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
ToTooltipWindowManager >> defaultPopupDelay [

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipWindowManager >> defaultPositionHook [

	^ [ :theWindow :theElement :event |
	  theWindow position: (event position x)
		  @ ((theElement localPointToGlobal: 0 @ theElement height) y + 5 ) ]
]

{ #category : #'api - accessing' }
ToTooltipWindowManager >> eventsToHandle [

	^ super eventsToHandle , { BlMouseLeaveEvent }
]

{ #category : #initialization }
ToTooltipWindowManager >> initialize [

	super initialize.
	self useNoMouseButton.
	popupOnMouseEnter := true.
	closeOnMouseLeave := true
]

{ #category : #'event handling' }
ToTooltipWindowManager >> mouseLeaveEvent: anEvent [

	self unqueuePopupTaskIn: anEvent currentTarget.
	closeOnMouseLeave ifFalse: [ ^ self ].
	self closeWindow

]

{ #category : #accessing }
ToTooltipWindowManager >> popupOnMouseDown [

	^ false
]

{ #category : #accessing }
ToTooltipWindowManager >> windowClass [

	^ ToTooltipWindow 
]
