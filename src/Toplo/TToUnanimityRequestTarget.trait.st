Trait {
	#name : #TToUnanimityRequestTarget,
	#category : #'Toplo-Core'
}

{ #category : #'t - prenotification target' }
TToUnanimityRequestTarget >> dispatchUnanimityRequest: anUnanimityRequestEvent [

	self dispatchEvent: anUnanimityRequestEvent.
	anUnanimityRequestEvent denied ifTrue: [ ^ self ].
	self dispatchEvent: anUnanimityRequestEvent sourceEvent
]

{ #category : #'t - prenotification target' }
TToUnanimityRequestTarget >> fireUnanimityRequest: anUnanimityRequestEvent [

	self fireEvent: anUnanimityRequestEvent.
	anUnanimityRequestEvent denied ifTrue: [ ^ self ].
	self dispatchEvent: anUnanimityRequestEvent sourceEvent
]
