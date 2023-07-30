Class {
	#name : #ToLabelWarningType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelWarningType >> textColorIn: anElement [

	^ anElement toTheme colorWarning
]
