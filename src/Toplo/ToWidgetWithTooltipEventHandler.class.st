Class {
	#name : #ToWidgetWithTooltipEventHandler,
	#superclass : #ToWidgetInPopupWindowEventHandler,
	#instVars : [
		'openTooltipTask'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> hideTooltipFor: aWidget [

	openTooltipTask ifNotNil: [ 
		aWidget dequeueTask: openTooltipTask.
		openTooltipTask := nil ].
	aWidget privateTooltipWindow ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: self widget

]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ self widget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: self widget

]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #private }
ToWidgetWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [

	self widget privateTooltipWindowDo: [ :tooltip | 
		tooltip content ifNil: [ ^ self ].
		tooltip parentDo: [ :p | tooltip close ].
		openTooltipTask := BlDelayedTaskAction new
			                   delay: self popupDelay;
			                   action: [ 
				                   tooltip popupEvent: anEvent.
				                   openTooltipTask := nil ].
		self widget enqueueTask: openTooltipTask ]
]

{ #category : #accessing }
ToWidgetWithTooltipEventHandler >> widget [

	^ self window widget
]
