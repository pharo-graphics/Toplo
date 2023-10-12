Extension { #name : #BlElement }

{ #category : #'*Toplo-Theme-Bee' }
BlElement >> defaultBeeStyleStamps [

	^ #( )
]

{ #category : #'*Toplo-Theme-Bee' }
BlElement >> initializeBeeStyle [ 

	self initializeRawStyle.
	self withAllStamps: self defaultBeeStyleStamps
]
