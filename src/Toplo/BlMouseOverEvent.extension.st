Extension { #name : #BlMouseOverEvent }

{ #category : #'*Toplo' }
BlMouseOverEvent >> asOutsideEvent [ 

	^ ToMouseOutsideEvent new copyFrom: self
]
