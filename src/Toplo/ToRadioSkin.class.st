Class {
	#name : #ToRadioSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToRadioSkin >> checkedImageIn: anElement [

	^ (super checkedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #accessing }
ToRadioSkin >> iconSkin [

	^ ToRadioImageSkin new.
]

{ #category : #accessing }
ToRadioSkin >> indeterminateImageIn: anElement [

	^ (super indeterminateImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]

{ #category : #accessing }
ToRadioSkin >> uncheckedImageIn: anElement [

	^ (super uncheckedImageIn: anElement)
		  geometry: BlCircleGeometry new;
		  yourself
]
