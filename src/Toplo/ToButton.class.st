Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToTriplet + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToTriplet classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - skin accessing' }
ToButton >> defaultSkin [ 

	"^ ToButtonSkin new"
	^ nil
]

{ #category : #'t - triplet - accessing' }
ToButton >> first [

	^ icon
]

{ #category : #'t - triplet - accessing' }
ToButton >> first: anElement [

	icon := anElement
]

{ #category : #'t - dressable -  initialization' }
ToButton >> preInitializeDresser [ 

	super preInitializeDresser.
	self initializeTriplet 
]

{ #category : #'t - triplet - accessing' }
ToButton >> second [

	^ label
]

{ #category : #'t - triplet - accessing' }
ToButton >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet - accessing' }
ToButton >> third [

	^ extra 
]

{ #category : #'t - triplet - accessing' }
ToButton >> third: anElement [

	extra := anElement

]
