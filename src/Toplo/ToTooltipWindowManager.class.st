Class {
	#name : 'ToTooltipWindowManager',
	#superclass : 'ToAnchoredWindowManager',
	#instVars : [
		'popupDelay'
	],
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'initialization' }
ToTooltipWindowManager >> defaulPositionHook [

	^ [ :event :theElement| 
	  event position x
	  @ (theElement localPointToGlobal: 0 @ theElement height) y + self vgap ]
]

{ #category : 'accessing' }
ToTooltipWindowManager >> defaultPopupDelay [

	^ 700 milliSeconds
]

{ #category : 'accessing' }
ToTooltipWindowManager >> elementEventHandlerClass [

	^ ToElementWithTooltipEventHandler 
]

{ #category : 'accessing' }
ToTooltipWindowManager >> popupDelay [

	^ popupDelay ifNil: [ popupDelay:= self defaultPopupDelay] 
]

{ #category : 'accessing' }
ToTooltipWindowManager >> popupDelay: aDuration [

	popupDelay := aDuration asDuration
]

{ #category : 'accessing' }
ToTooltipWindowManager >> vgap [

	^ 5
]

{ #category : 'accessing' }
ToTooltipWindowManager >> windowClass [

	^ ToTooltipWindow 
]
