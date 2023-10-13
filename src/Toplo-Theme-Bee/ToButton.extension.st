Extension { #name : #ToButton }

{ #category : #'*Toplo-Theme-Bee' }
ToButton >> defaultBeeStyleStamps [

	^ { #button }
]

{ #category : #'*Toplo-Theme-Bee' }
ToButton >> installBeeStyle [ 

	super installBeeStyle.
	self withStamp: #button
]
