Class {
	#name : #ToCommandPreApplicationEvent,
	#superclass : #ToPreNotificationEvent,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #accessing }
ToCommandPreApplicationEvent >> command [

	^ sourceEvent command
]

{ #category : #sending }
ToCommandPreApplicationEvent >> sendTo: anObject [

	anObject commandPreApplicationEvent: self
]
