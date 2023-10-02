Class {
	#name : #ToButtonDep,
	#superclass : #ToGeneralButton,
	#traits : 'TToTriplet + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToTriplet classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
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
	self withStamp: #button
]

{ #category : #'t - orientable - accessing' }
ToButtonDep >> layoutStrategy [

	^ self innerElement layout

	
]

{ #category : #'t - dressable -  initialization' }
ToButtonDep >> preInitializeDresser [ 

	super preInitializeDresser.
	self initializeTriplet
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
