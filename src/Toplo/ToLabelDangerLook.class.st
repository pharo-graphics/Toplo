Class {
	#name : #ToLabelDangerLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToLabelDangerLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorError
]
