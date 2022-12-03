Class {
	#name : #ToTooltipEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tooltipElement',
		'openTask'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #'api - accessing' }
ToTooltipEventHandler >> eventsToHandle [

	^ { 
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #'api - accessing' }
ToTooltipEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget close
]

{ #category : #'api - accessing' }
ToTooltipEventHandler >> mouseEnterEvent: anEvent [


]

{ #category : #'api - accessing' }
ToTooltipEventHandler >> mouseLeaveEvent: anEvent [


]
