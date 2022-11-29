Class {
	#name : #ToWidgetWithTooltipEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'openTooltipTask'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #'element handlers' }
ToWidgetWithTooltipEventHandler >> elementPositionChangedEvent: anEvent [

	anEvent currentTarget removePopup

]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> eventsToHandle [

	^ { BlElementPositionChangedEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> hideTooltipFor: aWidget [

	openTooltipTask ifNotNil: [ 
		aWidget dequeueTask: openTooltipTask.
		openTooltipTask := nil ].
	aWidget tooltip ifNotNil: [ :tooltip | tooltip removePopup ]
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> launchPopupTooltip: anEvent [

	anEvent currentTarget tooltipDo: [ :tooltip | 
		tooltip cleanUp.
		tooltip content ifEmpty: [ ^ self ].
		tooltip parentDo: [ :p | tooltip removeFromParent ].
		openTooltipTask := BlDelayedTaskAction new
			            delay: 700 milliSeconds;
			            action: [ 
				            self popupTooltipFor: anEvent currentTarget fromPosition: anEvent position.
				            openTooltipTask := nil ].
		anEvent currentTarget enqueueTask: openTooltipTask ]
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ anEvent currentTarget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self launchPopupTooltip: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> popupTooltipFor: aWidget fromPosition: aPosition [

	aWidget tooltip ifNil: [ ^ self ].
	aWidget tooltip popupFor: aWidget fromPosition: aPosition
]
