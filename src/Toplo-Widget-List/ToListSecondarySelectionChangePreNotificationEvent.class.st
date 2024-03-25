Class {
	#name : #ToListSecondarySelectionChangePreNotificationEvent,
	#superclass : #ToListChangePreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSecondarySelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject listSecondarySelectionChangePreNotificationEvent: self
]
