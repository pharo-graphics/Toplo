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
	#category : #'Toplo-Widget-Button-BasicButton'
}

{ #category : #'t - initialization dresser' }
ToButton >> defaultDresser [ 

	^ super defaultDresser next: ToTripletDresser new
]

{ #category : #'t - triplet - accessing' }
ToButton >> first [

	^ icon
]

{ #category : #'t - triplet - accessing' }
ToButton >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self addStyleClass: #button
]

{ #category : #'t - orientable - accessing' }
ToButton >> layoutStrategy [

	^ self innerElement layout

	
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
