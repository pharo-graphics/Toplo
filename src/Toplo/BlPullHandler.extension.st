Extension { #name : #BlPullHandler }

{ #category : #'*Toplo' }
BlPullHandler >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]
