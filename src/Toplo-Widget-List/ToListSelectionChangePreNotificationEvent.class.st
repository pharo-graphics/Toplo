Class {
	#name : #ToListSelectionChangePreNotificationEvent,
	#superclass : #ToListChangePreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject listSelectionChangePreNotificationEvent: self
]
