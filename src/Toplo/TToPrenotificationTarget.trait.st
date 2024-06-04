Trait {
	#name : #TToPrenotificationTarget,
	#category : #'Toplo-Core'
}

{ #category : #'t - prenotification target' }
TToPrenotificationTarget >> dispatchPreNotificationEvent: aPrenotificationEvent [

	self dispatchEvent: aPrenotificationEvent.
	aPrenotificationEvent sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: aPrenotificationEvent sourceEvent
]
