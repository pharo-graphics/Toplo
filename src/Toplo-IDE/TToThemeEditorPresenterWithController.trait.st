Trait {
	#name : #TToThemeEditorPresenterWithController,
	#instVars : [
		'controller'
	],
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
TToThemeEditorPresenterWithController >> controller [

	controller ifNil: [ controller := self defaultController ].
	^ controller
]

{ #category : #accessing }
TToThemeEditorPresenterWithController >> controllerClass [

	^ self shouldBeImplemented
]

{ #category : #accessing }
TToThemeEditorPresenterWithController >> defaultController [

	^ self controllerClass new
		              presenter: self;
		              yourself.
]
