Class {
	#name : #ToPreCheckableChangedEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable - accessing' }
ToPreCheckableChangedEvent >> checked [

	^ sourceEvent checked
]

{ #category : #sending }
ToPreCheckableChangedEvent >> sendTo: anObject [

	anObject preCheckableChangedEvent: self
]
