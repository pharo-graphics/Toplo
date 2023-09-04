Class {
	#name : #ToButton2,
	#superclass : #ToGeneralButton,
	#traits : 'TToTriplet + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToTriplet classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
	#instVars : [
		'#visualType',
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-BasicButton'
}

{ #category : #'t - initialization dresser' }
ToButton2 >> defaultDresser [ 

	^ super defaultDresser next: ToTripletDresser new
]

{ #category : #initialization }
ToButton2 >> defaultVisualType [

	"#default #primary #text #link"
	
	^ #default
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> first [

	^ icon
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToButton2 >> initialize [

	super initialize.
	self visualType: self defaultVisualType
]

{ #category : #'t - orientable - accessing' }
ToButton2 >> layoutStrategy [

	^ self innerElement layout

	
]

{ #category : #'t - dressable -  initialization' }
ToButton2 >> preInitializeDresser [ 

	super preInitializeDresser.
	self initializeTriplet
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> second [

	^ label
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> third [

	^ extra 
]

{ #category : #'t - triplet - accessing' }
ToButton2 >> third: anElement [

	extra := anElement

]

{ #category : #accessing }
ToButton2 >> visualType [

	^ visualType
]

{ #category : #accessing }
ToButton2 >> visualType: anObject [

	visualType := anObject
]
