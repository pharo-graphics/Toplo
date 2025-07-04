Extension { #name : #BlInfiniteLayoutConstraints }

{ #category : #'*Toplo' }
BlInfiniteLayoutConstraints >> hasHolder [

	^ holder notNil
]

{ #category : #'*Toplo' }
BlInfiniteLayoutConstraints >> holderDo: aValuable [

	holder ifNil: [ ^ self ].
	aValuable value: holder
]
