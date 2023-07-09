Trait {
	#name : #TToSkinable,
	#instVars : [
		'privateSkin'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - skin accessing' }
TToSkinable >> addLook: aLook [

	self checkSkin.
	privateSkin addLook: aLook
]

{ #category : #'t - skin accessing' }
TToSkinable >> checkSkin [

	privateSkin ifNil: [ self initializeSkin ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> defaultLook [

	^ ToNullElementLook new
]

{ #category : #'t - skin accessing' }
TToSkinable >> defaultSkin [

	^  ToWidgetSkin new
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
	privateSkin ifNotNil: [ privateSkin onInstalledIn: self ].

	
]

{ #category : #'t - skin accessing' }
TToSkinable >> withoutSkin [

	privateSkin ifNotNil: [
		privateSkin onUninstalledIn: self.
		privateSkin := nil ]
]
