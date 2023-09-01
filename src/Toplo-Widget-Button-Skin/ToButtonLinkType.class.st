Class {
	#name : #ToButtonLinkType,
	#superclass : #ToClickableType,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToButtonLinkType >> basicButtonIconSkinIn: anElement [

	^ ToButtonLinkIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularBackgroundLookIn: anElement [

	^ ToBackgroundLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelLinkType new
]
