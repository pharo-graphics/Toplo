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

	anEvent currentTarget close

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
	aWidget tooltip ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ anEvent currentTarget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> popupTooltipFor: aWidget fromEventPosition: aPosition [

	| ttPoint |
	aWidget tooltip ifNil: [ ^ self ].
	ttPoint := aPosition x @ (aWidget localPointToGlobal: 0 @ aWidget bounds bottom) y + self vgap.
	aWidget tooltip popupAtGlobalPosition: ttPoint
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [

	anEvent currentTarget tooltipDo: [ :tooltip | 
		tooltip content ifEmpty: [ ^ self ].
		tooltip parentDo: [ :p | tooltip close ].
		openTooltipTask := BlDelayedTaskAction new
			            delay: self popupDelay;
			            action: [ 
				            self popupTooltipFor: anEvent currentTarget fromEventPosition: anEvent position.
				            openTooltipTask := nil ].
		anEvent currentTarget enqueueTask: openTooltipTask ]
]

{ #category : #'showing / hiding' }
ToWidgetWithTooltipEventHandler >> vgap [

	^ 5
]
