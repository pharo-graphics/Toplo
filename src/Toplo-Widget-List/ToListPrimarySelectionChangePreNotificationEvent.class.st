Class {
	#name : #ToListPrimarySelectionChangePreNotificationEvent,
	#superclass : #ToListChangePreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangePreNotificationEvent: self
]
