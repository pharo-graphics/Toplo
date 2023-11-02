Class {
	#name : #ToElementWithTooltipEventHandler,
	#superclass : #ToAnchorEventHandler,
	#instVars : [
		'openTooltipTask'
	],
	#category : 'Toplo-Core-Tooltip'
}

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #private }
ToElementWithTooltipEventHandler >> hideTooltipFor: anElement [

	openTooltipTask ifNotNil: [ 
		anElement dequeueTask: openTooltipTask.
		openTooltipTask := nil ].
	anElement currentTooltipWindow ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ anEvent currentTarget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #private }
ToElementWithTooltipEventHandler >> popupDelay [

	^ windowHandler popupDelay
]

{ #category : #private }
ToElementWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [

		openTooltipTask := BlDelayedTaskAction new
			                   delay: self popupDelay;
			                   action: [ 
				                   (anEvent currentTarget newTooltipWindowEvent: anEvent) popupEvent: anEvent.
				                   openTooltipTask := nil ].
		anEvent currentTarget enqueueTask: openTooltipTask
]
