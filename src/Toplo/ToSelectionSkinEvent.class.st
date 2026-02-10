Class {
	#name : #ToSelectionSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'selectionOption',
		'holder'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSelectionSkinEvent >> focused [

	^ holder listElement isFocused
]

{ #category : #accessing }
ToSelectionSkinEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToSelectionSkinEvent >> holder: anHolder [

	holder := anHolder
]

{ #category : #testing }
ToSelectionSkinEvent >> isPrimary [ 

	^ false
]

{ #category : #accessing }
ToSelectionSkinEvent >> selectionMode [

	^ self selectionOption selectionMode
]

{ #category : #accessing }
ToSelectionSkinEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToSelectionSkinEvent >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]
