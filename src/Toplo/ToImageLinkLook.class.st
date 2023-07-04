Class {
	#name : #ToImageLinkLook,
	#superclass : #ToImageLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToImageLinkLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorLink
]

{ #category : #accessing }
ToImageLinkLook >> foregroundHoverFromElement: anElement [

	^ anElement toTheme colorLinkHover
]
