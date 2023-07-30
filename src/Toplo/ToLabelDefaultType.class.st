Class {
	#name : #ToLabelDefaultType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDefaultType >> textColorIn: anElement [

	^ anElement toTheme colorText
]
