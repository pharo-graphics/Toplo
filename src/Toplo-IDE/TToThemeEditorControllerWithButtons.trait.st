Trait {
	#name : #TToThemeEditorControllerWithButtons,
	#instVars : [
		'askBeforeRemove'
	],
	#traits : 'TToThemeEditorController',
	#classTraits : 'TToThemeEditorController classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
TToThemeEditorControllerWithButtons >> askBeforeRemove [

	^ askBeforeRemove
]

{ #category : #accessing }
TToThemeEditorControllerWithButtons >> askBeforeRemove: aBoolean [

	askBeforeRemove := aBoolean
]

{ #category : #testing }
TToThemeEditorControllerWithButtons >> isButtonAddEnabled [

	self shouldBeImplemented
]

{ #category : #testing }
TToThemeEditorControllerWithButtons >> isButtonRemoveEnabled [

	self shouldBeImplemented
]

{ #category : #removing }
TToThemeEditorControllerWithButtons >> removeDialogText [

	^ 'Are you sure ?'
]

{ #category : #removing }
TToThemeEditorControllerWithButtons >> removeWithBlock: aBlock [

	self askBeforeRemove ifFalse: [
		aBlock value.
		^ self ].

	(SpDialogWindowPresenter presenter: (SpLabelPresenter new
				  label: self removeDialogText;
				  yourself))
		okAction: aBlock;
		open
]
