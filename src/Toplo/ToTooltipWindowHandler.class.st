Class {
	#name : 'ToTooltipWindowHandler',
	#superclass : 'ToAnchoredWindowHandler',
	#instVars : [
		'popupDelay'
	],
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'initialization' }
ToTooltipWindowHandler >> defaulPositionHook [

	^ [ :event :theElement| 
	  event position x
	  @ (theElement localPointToGlobal: 0 @ theElement height) y + self vgap ]
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> defaultPopupDelay [

	^ 700 milliSeconds
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> elementEventHandlerClass [

	^ ToElementWithTooltipEventHandler 
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> popupDelay [

	^ popupDelay ifNil: [ popupDelay:= self defaultPopupDelay] 
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> popupDelay: aDuration [

	popupDelay := aDuration asDuration
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> vgap [

	^ 5
]

{ #category : 'accessing' }
ToTooltipWindowHandler >> windowClass [

	^ ToTooltipWindow 
]
