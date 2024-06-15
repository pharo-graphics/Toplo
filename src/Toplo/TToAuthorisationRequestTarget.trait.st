Trait {
	#name : #TToAuthorisationRequestTarget,
	#category : #'Toplo-Core'
}

{ #category : #'t - authorisation request target' }
TToAuthorisationRequestTarget >> dispatchAuthorisationRequest: aRequestEvent [

	self dispatchEvent: aRequestEvent.
	aRequestEvent denied ifTrue: [ ^ self ].
	aRequestEvent requestedAction value
]

{ #category : #'t - authorisation request target' }
TToAuthorisationRequestTarget >> fireAuthorisationRequest: aRequestEvent [

	self fireEvent: aRequestEvent.
	aRequestEvent denied ifTrue: [ ^ self ].
	aRequestEvent requestedAction value
]
