Trait {
	#name : #TToCheckableOwner,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable owner' }
TToCheckableOwner >> registerInCheckable [

	self checkableData registerHolder: self
]
