Class {
	#name : #ToLabelSecondaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToLabelSecondaryType >> textColorIn: anElement [

	^ anElement toTheme colorTextSecondary
]
