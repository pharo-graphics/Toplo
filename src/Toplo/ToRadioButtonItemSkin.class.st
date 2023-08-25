Class {
	#name : #ToRadioButtonItemSkin,
	#superclass : #ToCheckableMenuItemSkin,
	#traits : 'TToRadioButtonSkin',
	#classTraits : 'TToRadioButtonSkin classTrait',
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #accessing }
ToRadioButtonItemSkin >> iconSkinIn: aButton [ 

	^ self type radioButtonIconSkinIn: aButton

]
