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

	self hideTooltipFor: self associateElement

]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseEnterEvent: anEvent [

	openTooltipTask ifNotNil: [ self associateElement dequeueTask: openTooltipTask ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self prepareDelayedPopupTooltipFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToElementWithTooltipEventHandler >> mouseLeaveEvent: anEvent [

	self hideTooltipFor: self associateElement

]

{ #category : #private }
ToElementWithTooltipEventHandler >> popupDelay [

	^ 700 milliSeconds
]

{ #category : #private }
ToElementWithTooltipEventHandler >> prepareDelayedPopupTooltipFromEvent: anEvent [

	self associateElement privateTooltipWindowDo: [ :tooltip | 
		tooltip content ifNil: [ ^ self ].
		tooltip parentDo: [ :p | tooltip close ].
		openTooltipTask := BlDelayedTaskAction new
			                   delay: self popupDelay;
			                   action: [ 
				                   tooltip popupEvent: anEvent.
				                   openTooltipTask := nil ].
		self associateElement enqueueTask: openTooltipTask ]
]
