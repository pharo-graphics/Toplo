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
ToRadioButtonSkin >> iconSkin [

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
