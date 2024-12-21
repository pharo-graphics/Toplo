Trait {
	#name : #TToElementWithContentEditor,
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> beforeEditorClosed: anEditor fromManager: aManager [

	self explicitRequirement 
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> beforeEditorOpened: anEditor fromManager: aManager [

	self explicitRequirement 
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> newEditorForManager: aManager [
	" return the editor to use to edit the content of the element "

	^ self explicitRequirement
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> onInstalledEditorManager: anEditorManager [

	self explicitRequirement
]

{ #category : #'t - element with content editor' }
TToElementWithContentEditor >> onUninstalledEditorManager: anEditorManager [

	self explicitRequirement
]
