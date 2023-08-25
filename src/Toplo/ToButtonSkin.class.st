Class {
	#name : #ToButtonSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'instance creation' }
ToButtonSkin class >> defaultType [

	^ self type: ToButtonDefaultType new
]

{ #category : #'instance creation' }
ToButtonSkin class >> linkType [

	^ self type: ToButtonLinkType new
]

{ #category : #'instance creation' }
ToButtonSkin class >> primaryType [

	^ self type: ToButtonPrimaryType new
]

{ #category : #'instance creation' }
ToButtonSkin class >> textType [

	^ self type: ToButtonTextType new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> backgroundLookIn: anElement [

	^ self type basicButtonBackgroundLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> borderLookIn: anElement [

	^ self type basicButtonBorderLookIn: anElement
]

{ #category : #accessing }
ToButtonSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToButtonSkin >> iconSkinIn: aButton [

	^ self type basicButtonIconSkinIn: aButton

]

{ #category : #accessing }
ToButtonSkin >> labelSkinIn: aButton [

	^ self type basicButtonLabelSkinIn: aButton

]
