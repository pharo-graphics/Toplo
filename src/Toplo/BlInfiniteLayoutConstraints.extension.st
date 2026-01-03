Extension { #name : #BlInfiniteLayoutConstraints }

{ #category : #'*Toplo' }
BlInfiniteLayoutConstraints >> hasListHolder [

	^ holder notNil
]

{ #category : #'*Toplo' }
BlInfiniteLayoutConstraints >> listHolderDo: aValuable [

	self hasListHolder ifFalse: [ ^ nil ].
	^ aValuable value: holder
]
