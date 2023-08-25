Class {
	#name : #ToCheckboxSkin,
	#superclass : #ToCheckableSkin,
	#traits : 'TToCheckboxSkin',
	#classTraits : 'TToCheckboxSkin classTrait',
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToCheckboxSkin >> iconSkinIn: aButton [ 

	^ self type checkboxIconSkinIn: aButton

]
