Extension { #name : #ToButton }

{ #category : #'*Toplo-Theme-Bee' }
ToButton >> defaultBeeStyleStamps [

	^ { #button }
]

{ #category : #'*Toplo-Theme-Bee' }
ToButton >> initializeBeeStyle [ 

	super initializeBeeStyle.
	self withStamp: #button
]
