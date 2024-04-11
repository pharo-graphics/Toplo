Class {
	#name : #ToStyleStore,
	#superclass : #Object,
	#traits : 'TToStampsHolder + TToTokenPropertyIndexHolder',
	#classTraits : 'TToStampsHolder classTrait + TToTokenPropertyIndexHolder classTrait',
	#instVars : [
		'tokenPropertyIndex',
		'stampIndex'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [
	" changing a token property may require a install state and an initial state.
	This is done after installing a new skin "

	self tokenPropertyIndex changedAction: [
		self requestNewSkinRecursivelyFrom: anElement.
		anElement spaceDo: [ :sp | sp requestNextPulse ] ].
	self stampIndex changedAction: [
		self requestNewSkinRecursivelyFrom: anElement.
		anElement spaceDo: [ :sp | sp requestNextPulse ] ]
]

{ #category : #'t - stamps holder' }
ToStyleStore >> rawStampIndex [

	^ stampIndex
]

{ #category : #'t - stamps holder' }
ToStyleStore >> rawStampIndex: aPropertyIndex [

	stampIndex := aPropertyIndex

	
]

{ #category : #'t - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex [

	^ tokenPropertyIndex
]

{ #category : #'t - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex: aPropertyIndex [

	^ tokenPropertyIndex := aPropertyIndex
]

{ #category : #'api - hooks' }
ToStyleStore >> requestNewSkinRecursivelyFrom: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child requestNewSkin ]
]
