Trait {
	#name : #TToCheckableHolder,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable holder' }
TToCheckableHolder >> registerInCheckable [

	self checkableData registerHolder: self
]
