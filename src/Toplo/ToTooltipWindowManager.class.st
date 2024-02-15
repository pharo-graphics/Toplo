Class {
	#name : #ToTooltipWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'popupDelay'
	],
	#category : 'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindowManager >> defaultPopupDelay [

	^ 700 milliSeconds
]

{ #category : #initialization }
ToTooltipWindowManager >> defaultPositionHook [

	^ [ :theWindow :theElement :event |
	  theWindow position: (event position x)
		  @ ((theElement localPointToGlobal: 0 @ theElement height) y + self vgap) ]
]

{ #category : #accessing }
ToTooltipWindowManager >> elementEventHandlerClass [

	^ ToElementWithTooltipEventHandler 
]

{ #category : #accessing }
ToTooltipWindowManager >> popupDelay [

	^ popupDelay ifNil: [ popupDelay:= self defaultPopupDelay] 
]

{ #category : #accessing }
ToTooltipWindowManager >> popupDelay: aDuration [

	popupDelay := aDuration asDuration
]

{ #category : #accessing }
ToTooltipWindowManager >> vgap [

	^ 5
]

{ #category : #accessing }
ToTooltipWindowManager >> windowClass [

	^ ToTooltipWindow 
]
