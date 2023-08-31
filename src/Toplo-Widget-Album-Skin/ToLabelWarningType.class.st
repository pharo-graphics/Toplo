Class {
	#name : #ToLabelWarningType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToLabelWarningType >> textColorIn: anElement [

	^ anElement toTheme colorWarning
]
