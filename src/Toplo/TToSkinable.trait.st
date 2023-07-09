Trait {
	#name : #TToSkinable,
	#instVars : [
		'privateSkin'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - skin accessing' }
TToSkinable >> addLook: aLook [

	privateSkin ifNil: [ self initializeSkin ].
	privateSkin addLook: aLook
	
]

{ #category : #'t - skin accessing' }
TToSkinable >> defaultLook [

	^ ToNullElementLook new
]

{ #category : #'t - skin accessing' }
TToSkinable >> initializeSkin [

	self withSkin: ToElementSkin new
]

{ #category : #'t - skin accessing' }
TToSkinable >> privateSkin [

	^ privateSkin
]

{ #category : #'t - skin accessing' }
TToSkinable >> withSkin: aSkin [

	self withoutSkin.
	privateSkin := aSkin.
	privateSkin ifNotNil: [ self addEventHandler: privateSkin ].

	
]

{ #category : #'t - skin accessing' }
TToSkinable >> withoutSkin [

	privateSkin ifNotNil: [ self removeEventHandler: privateSkin ]
	
]
