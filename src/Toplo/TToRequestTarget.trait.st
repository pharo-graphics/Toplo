Trait {
	#name : #TToRequestTarget,
	#category : #'Toplo-Core'
}

{ #category : #'t -  request target' }
TToRequestTarget >> dispatchRequest: aRequestEvent [

	self dispatchEvent: aRequestEvent.
	aRequestEvent denied ifTrue: [ ^ self ].
	aRequestEvent requestedAction value
]
