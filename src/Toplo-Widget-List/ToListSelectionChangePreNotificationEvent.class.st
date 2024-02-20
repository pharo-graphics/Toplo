Class {
	#name : #ToListSelectionChangePreNotificationEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'selectionChangedEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangePreNotificationEvent >> selectionChangedEvent [

	^ selectionChangedEvent
]

{ #category : #accessing }
ToListSelectionChangePreNotificationEvent >> selectionChangedEvent: aSelectionChangedEvent [

	selectionChangedEvent := aSelectionChangedEvent
]

{ #category : #sending }
ToListSelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject listSelectionChangePreNotificationEvent: self
]
