Trait {
	#name : #TToThemeEditorControllerObservable,
	#instVars : [
		'observer',
		'observers'
	],
	#traits : 'TToThemeEditorController',
	#classTraits : 'TToThemeEditorController classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #adding }
TToThemeEditorControllerObservable >> addObserver: anObject [

	self observers add: anObject
]

{ #category : #adding }
TToThemeEditorControllerObservable >> observers [

	observers ifNil: [ observers := Set new ].
	^ observers
]
