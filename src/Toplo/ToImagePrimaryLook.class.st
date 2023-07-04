Class {
	#name : #ToImagePrimaryLook,
	#superclass : #ToImageLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToImagePrimaryLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorImageLightSolid
]
