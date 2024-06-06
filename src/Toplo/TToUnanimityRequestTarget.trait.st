Trait {
	#name : #TToUnanimityRequestTarget,
	#category : #'Toplo-Core'
}

{ #category : #'t - prenotification target' }
TToUnanimityRequestTarget >> dispatchUnanimityRequest: anUnanimityRequestEvent [

	self dispatchEvent: anUnanimityRequestEvent.
	anUnanimityRequestEvent sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: anUnanimityRequestEvent sourceEvent
]
