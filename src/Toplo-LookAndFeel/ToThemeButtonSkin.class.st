Class {
	#name : #ToThemeButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #'events - handling' }
ToThemeButtonSkin >> onInstalledIn: anElement [
	
	super onInstalledIn: anElement.
	
	"Default layout"
	anElement layout alignCenter.
]
