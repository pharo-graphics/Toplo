Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> hasHolder [

	^ self hasInfinite and: [ self infinite hasHolder ]
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> hasInfinite [

	^ self hasConstraintsForLayout: BlInfiniteLayout
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> holderDo: aValuable [

	self infiniteDo: [ :i | i holderDo: aValuable ]
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> infiniteDo: aValuable [

	self hasInfinite ifFalse: [ ^ self ].
	aValuable value: self infinite
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> triplet [ 

	^ self at: ToTripletLayout 
]
