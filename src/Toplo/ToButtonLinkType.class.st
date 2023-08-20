Class {
	#name : #ToButtonLinkType,
	#superclass : #ToButtonType,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'basic button' }
ToButtonLinkType >> basicButtonIconSkinIn: anElement [

	^ ToButtonLinkIconSkin new danger: self danger
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularBackgroundLookIn: anElement [

	^ nil
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkType >> regularLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelLinkType new
]
