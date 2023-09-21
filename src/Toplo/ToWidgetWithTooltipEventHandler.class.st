Class {
	#name : #ToWidgetWithTooltipEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'openTooltipTask',
		'widget'
	],
	#category : 'Toplo-Core-Tooltip'
}

{ #category : #'element handlers' }
ToWidgetWithTooltipEventHandler >> elementPositionChangedEvent: anEvent [

	widget tooltip close

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

	self hideTooltipFor: widget

]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ widget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: widget

]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [

	widget tooltipDo: [ :tooltip | 
		tooltip content ifEmpty: [ ^ self ].
		tooltip parentDo: [ :p | tooltip close ].
		openTooltipTask := BlDelayedTaskAction new
			                   delay: self popupDelay;
			                   action: [ 
				                   tooltip popupEvent: anEvent.
				                   openTooltipTask := nil ].
		widget enqueueTask: openTooltipTask ]
]

{ #category : #accessing }
ToWidgetWithTooltipEventHandler >> widget [

	^ widget
]

{ #category : #accessing }
ToWidgetWithTooltipEventHandler >> widget: aWidget [

	widget := aWidget
]
