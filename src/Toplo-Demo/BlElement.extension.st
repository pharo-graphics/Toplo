Extension { #name : #BlElement }

{ #category : #'*Toplo-Demo' }
BlElement >> defaultButterflySkin: aSkin [

	self ensuredSkinManager setDefaultButterflySkin: aSkin in: self 
]

{ #category : #'*Toplo-Demo' }
BlElement >> installButterflyStyle [

	
]

{ #category : #'*Toplo-Demo' }
BlElement >> newButterflySkin [

	^  ToButterflySkin new
]

{ #category : #'*Toplo-Demo' }
BlElement >> uninstallButterflyStyle [

	
]
