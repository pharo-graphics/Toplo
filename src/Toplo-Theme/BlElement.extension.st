Extension { #name : 'BlElement' }

{ #category : '*Toplo-Theme' }
BlElement >> defaultSkin [

	^  self userData at: #defaultSkin ifAbsent: [self styleSheetInterpreter skinFor: self]
]

{ #category : '*Toplo-Theme' }
BlElement >> defaultSkin: aSkin [

	self userData at: #defaultSkin put: aSkin
]
