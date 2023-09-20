Class {
	#name : 'ToTripletElement',
	#superclass : 'ToWidget',
	#traits : 'TToTriplet + TToOrientable',
	#classTraits : 'TToTriplet classTrait + TToOrientable classTrait',
	#instVars : [
		'first',
		'second',
		'third'
	],
	#category : 'Toplo-Core-Triplet',
	#package : 'Toplo',
	#tag : 'Core-Triplet'
}

{ #category : 't - dressable -  initialization' }
ToTripletElement >> defaultDresser [ 

	^ ToTripletDresser new
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> first [

	^ first
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> first: anElement [

	first := anElement
]

{ #category : 'initialization' }
ToTripletElement >> initialize [

	super initialize.
	self initializeTriplet 
]

{ #category : 't - orientable - accessing' }
ToTripletElement >> layoutStrategy [

	^ self innerElement layout
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> second [

	^ second 
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> second: anElement [

	second := anElement
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> third [

	^ third
]

{ #category : 't - triplet - accessing' }
ToTripletElement >> third: anElement [

	third := anElement

]
