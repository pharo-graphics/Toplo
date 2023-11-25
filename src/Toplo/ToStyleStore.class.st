Class {
	#name : 'ToStyleStore',
	#superclass : 'Object',
	#traits : 'TToStampsHolder + TToTokenPropertyIndexHolder',
	#classTraits : 'TToStampsHolder classTrait + TToTokenPropertyIndexHolder classTrait',
	#instVars : [
		'tokenPropertyIndex',
		'stampSet'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [

	" changing a token property may require a install state and an initial state.
	This is done after installing a new skin "
	self tokenPropertyIndex changedAction: [ anElement requestNewSkinRecursively ].
	self stampSet changedAction: [ anElement requestNewSkinRecursively ]
]

{ #category : 't - stamps holder' }
ToStyleStore >> rawStampSet [

	^ stampSet
]

{ #category : 't - stamps holder' }
ToStyleStore >> rawStampSet: aSet [

	stampSet := aSet
]

{ #category : 't - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex [

	^ tokenPropertyIndex
]

{ #category : 't - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex: aPropertyIndex [

	^ tokenPropertyIndex := aPropertyIndex
]
