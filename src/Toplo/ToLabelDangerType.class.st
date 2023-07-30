Class {
	#name : #ToLabelDangerType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDangerType >> textColorIn: anElement [

	^ anElement toTheme colorError
]
