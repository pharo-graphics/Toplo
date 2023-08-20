Class {
	#name : #ToBasicButtonSkin,
	#superclass : #ToAbstractButtonSkinNew,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'instance creation' }
ToBasicButtonSkin class >> defaultType [

	^ self type: ToButtonDefaultType new
]

{ #category : #'instance creation' }
ToBasicButtonSkin class >> linkType [

	^ self type: ToButtonLinkType new
]

{ #category : #'instance creation' }
ToBasicButtonSkin class >> primaryType [

	^ self type: ToButtonPrimaryType new
]

{ #category : #'instance creation' }
ToBasicButtonSkin class >> textType [

	^ self type: ToButtonTextType new
]

{ #category : #'api - install/uninstall  hook' }
ToBasicButtonSkin >> backgroundLookIn: anElement [

	^ self type basicButtonBackgroundLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicButtonSkin >> borderLookIn: anElement [

	^ self type basicButtonBorderLookIn: anElement
]

{ #category : #accessing }
ToBasicButtonSkin >> iconSkinIn: aButton [

	^ self type basicButtonIconSkinIn: aButton

]

{ #category : #accessing }
ToBasicButtonSkin >> labelSkinIn: aButton [

	^ self type basicButtonLabelSkinIn: aButton

]
