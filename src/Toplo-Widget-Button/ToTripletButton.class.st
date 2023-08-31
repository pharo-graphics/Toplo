Class {
	#name : #ToTripletButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToTriplet',
	#classTraits : 'TToTriplet classTrait',
	#instVars : [
		'#first => ToSkinnableSlot',
		'#second => ToSkinnableSlot',
		'#third => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - initialization dresser' }
ToTripletButton >> defaultDresser [ 

	^ super defaultDresser next: ToTripletDresser new
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> first [

	^ first
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> first: anElement [

	first := anElement
]

{ #category : #initialization }
ToTripletButton >> initialize [

	super initialize.
	self initializeTriplet
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> second [

	^ second
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> second: anElement [

	second := anElement
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> third [

	^ third
]

{ #category : #'t - triplet - accessing' }
ToTripletButton >> third: anElement [

	third := anElement

]
