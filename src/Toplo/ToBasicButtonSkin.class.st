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

{ #category : #accessing }
ToBasicButtonSkin >> iconSkinIn: aButton [

	^ self type basicButtonIconSkinIn: aButton

]

{ #category : #accessing }
ToBasicButtonSkin >> labelSkinIn: aButton [

	^ self type basicButtonLabelSkinIn: aButton

]
