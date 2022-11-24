Class {
	#name : #ToWidgetMinimalEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'openTooltipTask'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - accessing' }
ToWidgetMinimalEventHandler >> eventsToHandle [

	^ { 
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #private }
ToWidgetMinimalEventHandler >> hideTooltipFor: aWidget [

	openTooltipTask ifNotNil: [ 
		aWidget dequeueTask: openTooltipTask.
		openTooltipTask := nil ].
	aWidget tooltip ifNotNil: [ :tooltip | tooltip removePopup ]
]

{ #category : #'api - accessing' }
ToWidgetMinimalEventHandler >> launchPopup: anEvent [

	anEvent currentTarget tooltipDo: [ :tooltip | 
		tooltip content ifEmpty: [ ^ self ].
		openTooltipTask := BlDelayedTaskAction new
			            delay: 700 milliSeconds;
			            action: [ 
				            self popupTooltipFor: anEvent currentTarget.
				            openTooltipTask := nil ].
		anEvent currentTarget enqueueTask: openTooltipTask ]
]

{ #category : #'api - accessing' }
ToWidgetMinimalEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #'api - accessing' }
ToWidgetMinimalEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ anEvent currentTarget dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self launchPopup: anEvent
]

{ #category : #'api - accessing' }
ToWidgetMinimalEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: anEvent currentTarget

]

{ #category : #private }
ToWidgetMinimalEventHandler >> popupTooltipFor: aWidget [

	aWidget tooltip ifNil: [ ^ self ].
	aWidget tooltip popupFor: aWidget
]
