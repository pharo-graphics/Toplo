Class {
	#name : #ToLabelSecondaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelSecondaryType >> textColorIn: anElement [

	^ anElement toTheme colorTextSecondary
]
