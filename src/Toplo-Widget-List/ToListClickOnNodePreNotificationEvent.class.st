Class {
	#name : #ToListClickOnNodePreNotificationEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodePreNotificationEvent >> sendTo: anObject [

	anObject listClickOnNodePreNotificationEvent: self
]
