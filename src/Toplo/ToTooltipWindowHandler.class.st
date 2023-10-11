Class {
	#name : #ToTooltipWindowHandler,
	#superclass : #ToAnchoredWindowHandler,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #initialization }
ToTooltipWindowHandler >> defaulPositionHook [

	^ [ :event |
	  event position x
	  @ (element localPointToGlobal: 0 @ element height) y + self vgap ]
]

{ #category : #accessing }
ToTooltipWindowHandler >> elementEventHandlerClass [

	^ ToElementWithTooltipEventHandler 
]

{ #category : #accessing }
ToTooltipWindowHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #accessing }
ToTooltipWindowHandler >> vgap [

	^ 5
]
