Class {
	#name : #ToLabelSecondaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToLabelSecondaryType >> textColorIn: anElement [

	^ anElement toTheme colorTextSecondary
]
