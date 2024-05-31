Class {
	#name : #ToListPrimarySelectionChangePreNotificationEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangePreNotificationEvent: self
]
