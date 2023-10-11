Class {
	#name : #ToButtonDep,
	#superclass : #ToGeneralButton,
	#traits : 'TToTriplet + TToOrientable + TToLabeledIcon',
	#classTraits : 'TToTriplet classTrait + TToOrientable classTrait + TToLabeledIcon classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-BasicButton'
}

{ #category : #'t - skinable - initialization' }
ToButtonDep >> defaultStyleStamps [

	^ { #button }
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> first [

	^ icon
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToButtonDep >> initialize [

	super initialize.
	self initializeTriplet.
	self withStamp: #button
]

{ #category : #'t - orientable - accessing' }
ToButtonDep >> layoutStrategy [

	^ self innerElement layout

	
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> second [

	^ label
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> third [

	^ extra 
]

{ #category : #'t - triplet - accessing' }
ToButtonDep >> third: anElement [

	extra := anElement

]
