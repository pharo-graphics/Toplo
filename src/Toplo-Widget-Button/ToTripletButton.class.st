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

{ #category : #'t - triplet - initialization' }
ToTripletButton >> initializeTriplet [

	self layout: BlLinearLayout horizontal.
	self justified: false.
	innerElement := ToElement new layout: BlLinearLayout horizontal; fitContent.
	innerElement styleTag: #'inner-element'.
	self addChild: innerElement.
	self fitContent.
	filler1 := ToElement new
		  styleTag: #'triplet-filler-1';
		  size: 0 @ 0;
		  yourself.
	filler2 := ToElement new
		  styleTag: #'triplet-filler-2';
		  size: 0 @ 0;
		  yourself.
	self innerElement addChildren: { filler1. filler2 }


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
