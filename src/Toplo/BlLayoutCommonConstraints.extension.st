Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> annulus [

	^ self at: ToAnnulusCircularLayout 
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> annulusSector [

	^ self at: ToAnnulusSectorLayout 
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> hasInfinite [

	^ self hasConstraintsForLayout: BlInfiniteLayout
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> hasListHolder [

	^ self hasInfinite and: [ self infinite hasListHolder ]
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> infiniteDo: aValuable [

	self hasInfinite ifFalse: [ ^ nil ].
	^ aValuable value: self infinite
]

{ #category : #'*Toplo' }
BlLayoutCommonConstraints >> listHolderDo: aValuable [

	^ self infiniteDo: [ :i | i listHolderDo: aValuable ]
]
