Class {
	#name : #ToLabelSuccessType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelSuccessType >> textColorIn: anElement [

	^ anElement toTheme colorSuccess
]
