Class {
	#name : #ToLabelDangerLook,
	#superclass : #ToLabelLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToLabelDangerLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorError
]
