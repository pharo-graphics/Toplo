Class {
	#name : #ToListChangePreNotificationEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListChangePreNotificationEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListChangePreNotificationEvent >> sourceEvent: aSelectionChangedEvent [

	sourceEvent := aSelectionChangedEvent
]
