Trait {
	#name : #TToElementWithFloatOverlay,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with float overlay' }
TToElementWithFloatOverlay >> floatOverlay [

	^ self userData at: #floatOverlay ifAbsentPut: [
			  | overlay |
			  overlay := ToFloatOverlay new.
			  overlay attachToParent: self.
			  overlay ]
]
