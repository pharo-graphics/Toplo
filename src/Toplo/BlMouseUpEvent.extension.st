Extension { #name : #BlMouseUpEvent }

{ #category : #'*Toplo' }
BlMouseUpEvent >> asOutsideEvent [ 

	^ ToMouseUpOutsideEvent new copyFrom: self
]
