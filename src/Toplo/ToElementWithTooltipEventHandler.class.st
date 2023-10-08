Class {
	#name : #ToElementWithTooltipEventHandler,
	#superclass : #ToPopupWindowAssociateElementEventHandler,
	#instVars : [
		'openTooltipTask'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToElementWithTooltipEventHandler >> associateElement [

	^ self window associateElement
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #private }
ToElementWithTooltipEventHandler >> hideTooltipFor: aWidget [

	openTooltipTask ifNotNil: [ 
		aWidget dequeueTask: openTooltipTask.
		openTooltipTask := nil ].
	aWidget privateTooltipWindow ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseDownEvent: anEvent [

	self hideTooltipFor: target

]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ self associateElement dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: target

]

{ #category : #private }
ToElementWithTooltipEventHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #private }
ToElementWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [


		associateWindow content ifNil: [ ^ self ].
		associateWindow parentDo: [ :p | associateWindow close ].
		openTooltipTask := BlDelayedTaskAction new
			                   delay: self popupDelay;
			                   action: [ 
				                   associateWindow popupEvent: anEvent.
				                   openTooltipTask := nil ].
		target enqueueTask: openTooltipTask
]
