Class {
	#name : #ToTooltipWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Core-Tooltip'
}

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

{ #category : #accessing }
ToTooltipWindowManager >> elementEventHandlerClass [

	^ ToElementWithTooltipEventHandler 
]

{ #category : #initialization }
ToTooltipWindowManager >> initialize [

	super initialize.
	self useNoMouseButton.
	popupOnMouseEnter := true.
	closeOnMouseLeave := true.
	popupOnMouseDown := false.
	closeOnMouseDown := true
]

{ #category : #accessing }
ToTooltipWindowManager >> windowClass [

	^ ToTooltipWindow 
]

{ #category : #accessing }
ToTooltipWindowManager >> windowClosedEventClass [

	^ ToTooltipWindowClosedEvent
]

{ #category : #accessing }
ToTooltipWindowManager >> windowOpenedEventClass [

	^ ToTooltipWindowOpenedEvent
]
