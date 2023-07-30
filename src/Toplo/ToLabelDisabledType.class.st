Class {
	#name : #ToLabelDisabledType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDisabledType >> textColorIn: anElement [

	^ anElement toTheme colorText
]
