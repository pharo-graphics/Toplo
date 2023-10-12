Extension { #name : #ToElement }

{ #category : #'*Toplo-Theme-Bee' }
ToElement >> defaultBeeStyleStamps [

	^ #( )
]

{ #category : #'*Toplo-Theme-Bee' }
ToElement >> initializeBeeStyle [ 

	self initializeRawStyle.
	self withAllStamps: self defaultBeeStyleStamps
]
