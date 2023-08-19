Class {
	#name : #ToButtonSkin,
	#superclass : #ToAbstractButtonSkinNew,
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

{ #category : #'t - reshapeable - initialization' }
ToButtonSkin >> defaultShaping [

	^ ToDefaultShaping new 
]

{ #category : #accessing }
ToButtonSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToButtonSkin >> iconSkinIn: aButton [

	^ ToButtonIconSkin new buttonType: self type.

]

{ #category : #accessing }
ToButtonSkin >> labelSkinIn: aButton [

	^ ToButtonLabelSkin new buttonType: self type.

]
