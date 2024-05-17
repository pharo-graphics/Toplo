Trait {
	#name : #TToElementWithSelectionMode,
	#category : #'Toplo-Core'
}

{ #category : #accessing }
TToElementWithSelectionMode >> rawSelectionMode: aSelectionMode [

	self explicitRequirement
]

{ #category : #accessing }
TToElementWithSelectionMode >> selectionMode [

	self explicitRequirement
]

{ #category : #accessing }
TToElementWithSelectionMode >> selectionMode: aSelectionMode [

	self selectionMode ifNotNil: [
		self selectionMode onUninstalledIn: self ].
	self rawSelectionMode: aSelectionMode.
	self selectionMode ifNotNil: [
		self selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
TToElementWithSelectionMode >> selectionModel [

	^ self selectionMode selectionModel
]
