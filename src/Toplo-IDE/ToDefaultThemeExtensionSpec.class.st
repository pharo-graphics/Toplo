Class {
	#name : #ToDefaultThemeExtensionSpec,
	#superclass : #ToSkinThemeExtensionSpec,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToDefaultThemeExtensionSpec >> defaultLayout [

	^ SpBoxLayout newHorizontal add: SpNullPresenter new; yourself
]
