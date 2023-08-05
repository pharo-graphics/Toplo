Trait {
	#name : #TToLabelAndIconWithSkinHolder,
	#instVars : [
		'#icon => ToPropertyWithSkinSlot',
		'#label => ToPropertyWithSkinSlot',
		'#extra => ToPropertyWithSkinSlot'
	],
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> first [

	^ icon
]

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> first: anElement [

	icon := anElement
]

{ #category : #'t - triplet initialization' }
TToLabelAndIconWithSkinHolder >> initializeLabeledIconWithSkin [

	self initializeTriplet 
]

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> second [

	^ label
]

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> third [

	^ extra
]

{ #category : #'t - triplet accessing' }
TToLabelAndIconWithSkinHolder >> third: anElement [

	extra := anElement

]
