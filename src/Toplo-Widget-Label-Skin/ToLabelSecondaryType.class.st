Class {
	#name : #ToLabelSecondaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToLabelSecondaryType >> textColorIn: anElement [

	^ anElement toTheme colorTextSecondary
]
