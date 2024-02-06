Trait {
	#name : #TToThemeEditorObservable,
	#instVars : [
		'observer',
		'observers'
	],
	#classTraits : 'TToThemeEditorController classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #adding }
TToThemeEditorObservable >> addObserver: anObject [

	self observers add: anObject
]

{ #category : #adding }
TToThemeEditorObservable >> observers [

	observers ifNil: [ observers := Set new ].
	^ observers
]
