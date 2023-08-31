Class {
	#name : #ToLabelWarningType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToLabelWarningType >> textColorIn: anElement [

	^ anElement toTheme colorWarning
]
