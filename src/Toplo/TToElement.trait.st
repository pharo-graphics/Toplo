Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> asFloatElement [

	| holder |
	holder := ToFloatElement new.
	holder builder: [:e | e addChild: self].
	^ holder
]

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureCanManageSkin
]
