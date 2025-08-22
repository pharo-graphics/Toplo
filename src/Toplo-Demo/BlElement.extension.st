Extension { #name : #BlElement }

{ #category : #'*Toplo-Demo' }
BlElement >> defaultButterflySkin [

	^ self userData at: #defaultButterflySkin ifAbsent: [  ]
]

{ #category : #'*Toplo-Demo' }
BlElement >> defaultButterflySkin: aSkin [

	self defaultButterflySkin = aSkin ifTrue: [ ^ self ].
	self userData at: #defaultButterflySkin put: aSkin.
	self requestNewSkin
	
]

{ #category : #'*Toplo-Demo' }
BlElement >> installButterflyStyle [

	
]

{ #category : #'*Toplo-Demo' }
BlElement >> newButterflySkin [

	^  ToButterflySkin new
]

{ #category : #'*Toplo-Demo' }
BlElement >> newSkinDemoSkin [ 

	^ ToSkinDemoSkin new
]

{ #category : #'*Toplo-Demo' }
BlElement >> uninstallButterflyStyle [

	
]
