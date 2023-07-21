Trait {
	#name : #TToSkinable,
	#instVars : [
		'privateSkin'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - skin accessing' }
TToSkinable >> addLook: aLook [

	self checkSkin.
	privateSkin ifNil: [ ^ self ].
	privateSkin addLook: aLook
]

{ #category : #'t - skin accessing' }
TToSkinable >> checkSkin [

	privateSkin ifNil: [ self initializeSkin ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> defaultSkin [

	^  nil
]

{ #category : #'t - skin accessing' }
TToSkinable >> initializeSkin [

	self withSkin: self defaultSkin
]

{ #category : #'t - skin accessing' }
TToSkinable >> privateSkin [

	^ privateSkin
]

{ #category : #'t - skin accessing' }
TToSkinable >> withSkin: aSkin [

	self withoutSkin.
	privateSkin := aSkin.
	Toplo useLookAndFeel ifTrue: [ ^ self ].
	privateSkin ifNotNil: [
		self addEventHandler: privateSkin.
		self requestLayout.
		self dispatchSkinChangedEvent ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> withoutSkin [

	privateSkin ifNotNil: [
		self removeEventHandler: privateSkin.
		privateSkin := nil ]
]
