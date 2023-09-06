Class {
	#name : #ToButton2,
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

{ #category : #'api - accessing' }
ToButton2 >> childSkinsToHandle [
 
	^ {
		  (ToChildSkinBuilder new
			   slotName: #icon;
			   builder: [ :e | self toTheme skinFor: e ];
			   yourself).
		  (ToChildSkinBuilder new
			   slotName: #label;
			   builder: [ :e | self toTheme skinFor: e ];
			   yourself) }
]

{ #category : #'t - initialization dresser' }
ToButton2 >> defaultDresser [ 

	^ super defaultDresser next: ToTripletDresser new
]

{ #category : #'t - skinable - initialization' }
ToButton2 >> defaultStyleClasses [

	^ #( #button )
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
	self addStyleClass: #button.

	
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
