Class {
	#name : #ToDefaultThemeSpecializationPresenter,
	#superclass : #ToThemeSpecializationPresenter,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToDefaultThemeSpecializationPresenter >> defaultLayout [

	^ SpBoxLayout newVertical add: SpNullPresenter new; yourself.
]
