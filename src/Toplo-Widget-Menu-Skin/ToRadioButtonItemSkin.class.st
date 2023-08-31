Class {
	#name : #ToRadioButtonItemSkin,
	#superclass : #ToCheckableMenuItemSkin,
	#traits : 'TToRadioButtonSkin',
	#classTraits : 'TToRadioButtonSkin classTrait',
	#category : #'Toplo-Widget-Menu-Skin'
}

{ #category : #accessing }
ToRadioButtonItemSkin >> iconSkinIn: aButton [ 

	^ self type radioButtonIconSkinIn: aButton

]
