Class {
	#name : #ToPopupWindowOpenedEvent,
	#superclass : #ToPopupWindowEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToPopupWindowOpenedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToPopupWindowOpenedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
