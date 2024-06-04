Class {
	#name : #ToSieveSelectionChangePreNotificationEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToSieveSelectionChangePreNotificationEvent >> sendTo: anObject [

	anObject sieveSelectionChangePreNotificationEvent: self
]
