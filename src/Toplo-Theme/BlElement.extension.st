Extension { #name : #BlElement }

{ #category : #'*Toplo-Theme' }
BlElement >> defaultSkin [
self traceCr.
	^  self skinBuilder skinFor: self
]

{ #category : #'*Toplo-Theme' }
BlElement >> defaultSkin: aSkin [

	self userData at: #defaultSkin put: aSkin
]
