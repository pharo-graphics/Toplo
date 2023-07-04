Class {
	#name : #ToButtonImageDangerLook,
	#superclass : #ToButtonImageLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorError
]

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundHoverFromElement: anElement [

	^ anElement toTheme colorErrorHover
]

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundPressedFromElement: anElement [

	^ anElement toTheme colorError darker
]
