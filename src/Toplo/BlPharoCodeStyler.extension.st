Extension { #name : #BlPharoCodeStyler }

{ #category : #'*Toplo' }
BlPharoCodeStyler >> styleTable [

	^ shoutStyler class styleTable
]

{ #category : #'*Toplo' }
BlPharoCodeStyler >> styleTable: aStyleTable [

	self styleTable = aStyleTable ifTrue: [ ^ self ].
	shoutStyler class styleTable: aStyleTable
]
