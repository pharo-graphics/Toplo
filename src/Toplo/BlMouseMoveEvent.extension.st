Extension { #name : #BlMouseMoveEvent }

{ #category : #'*Toplo' }
BlMouseMoveEvent >> asOutsideEvent [ 

	^ ToMouseMoveOutsideEvent new copyFrom: self
]
