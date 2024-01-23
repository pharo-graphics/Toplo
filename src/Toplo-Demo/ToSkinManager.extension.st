Extension { #name : #ToSkinManager }

{ #category : #'*Toplo-Demo' }
ToSkinManager >> defaultButterflySkin [

	^ self userData at: #defaultButterflySkin ifAbsent: [  ]
]

{ #category : #'*Toplo-Demo' }
ToSkinManager >> defaultButterflySkin: aSkin [

	^ self userData at: #defaultButterflySkin put: aSkin
]

{ #category : #'*Toplo-Demo' }
ToSkinManager >> setDefaultButterflySkin: aSkin in: anElement [

	self defaultButterflySkin = aSkin ifTrue: [ ^ self ].
	skinInstallRequestCount := 0.
	self defaultButterflySkin: aSkin.
	anElement requestNewSkin
]
