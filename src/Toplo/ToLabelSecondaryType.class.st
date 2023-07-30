Class {
	#name : #ToLabelSecondaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelSecondaryType >> textColorIn: anElement [

	^ anElement toTheme colorTextSecondary
]
