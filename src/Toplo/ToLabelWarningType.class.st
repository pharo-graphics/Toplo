Class {
	#name : #ToLabelWarningType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelWarningType >> textColorIn: anElement [

	^ anElement toTheme colorWarning
]
