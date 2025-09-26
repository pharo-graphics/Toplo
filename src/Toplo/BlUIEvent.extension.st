Extension { #name : #BlUIEvent }

{ #category : #'*Toplo' }
BlUIEvent >> asOutsideEvent [ 

	^ ToAnyUIEventOutsideEvent new copyFrom: self
]
