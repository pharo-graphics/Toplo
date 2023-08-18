Class {
	#name : #ToRadioButtonSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToRadioButtonSkin >> checkedImageIn: anElement [

	^ (super checkedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #accessing }
ToRadioButtonSkin >> disabledImageIn: anElement [

	^ (super disabledImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #accessing }
ToRadioButtonSkin >> iconSkinIn: aButton [

	^ ToRadioButtonIconSkin new.
]

{ #category : #accessing }
ToRadioButtonSkin >> indeterminateImageIn: anElement [

	^ (super indeterminateImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #accessing }
ToRadioButtonSkin >> uncheckedImageIn: anElement [

	^ (super uncheckedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]
