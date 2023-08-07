Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#instVars : [
		'#icon => ToPropertyWithSkinSlot',
		'#label => ToPropertyWithSkinSlot',
		'#extra => ToPropertyWithSkinSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - skin accessing' }
ToButton >> defaultSkin [ 

	"^ ToButtonSkin new"
	^ nil
]

{ #category : #'t - triplet accessing' }
ToButton >> first [

	^ icon
]

{ #category : #'t - triplet accessing' }
ToButton >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self initializeTriplet


]

{ #category : #'t - triplet accessing' }
ToButton >> second [

	^ label
]

{ #category : #'t - triplet accessing' }
ToButton >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet accessing' }
ToButton >> third [

	^ extra 
]

{ #category : #'t - triplet accessing' }
ToButton >> third: anElement [

	extra := anElement

]
